#!/usr/bin/env bash
set -euo pipefail

: "${GCP_PROJECT_ID:?Set GCP_PROJECT_ID}"
: "${GCP_NOTIFICATION_CHANNEL:?Set GCP_NOTIFICATION_CHANNEL to a Monitoring notification-channel resource name}"

create_or_update_metric() {
  local name="$1"
  local description="$2"
  local filter="$3"
  if gcloud logging metrics describe "$name" --project="$GCP_PROJECT_ID" >/dev/null 2>&1; then
    gcloud logging metrics update "$name" \
      --project="$GCP_PROJECT_ID" \
      --description="$description" \
      --log-filter="$filter"
  else
    gcloud logging metrics create "$name" \
      --project="$GCP_PROJECT_ID" \
      --description="$description" \
      --log-filter="$filter"
  fi
}

create_or_update_metric \
  studium_dead_letter_jobs \
  'Durable jobs that reached dead-letter state.' \
  'jsonPayload.outcome="dead_letter"'

create_or_update_metric \
  studium_opportunity_refresh_failures \
  'Opportunity source refreshes that failed.' \
  'jsonPayload.event="opportunity_source_refresh_failed"'

policy_file="$(mktemp)"
trap 'rm -f "$policy_file"' EXIT

apply_policy() {
  local template="$1"
  local display_name="$2"
  sed "s|__NOTIFICATION_CHANNEL__|$GCP_NOTIFICATION_CHANNEL|g" "$template" >"$policy_file"
  local policy_name
  policy_name="$(gcloud monitoring policies list \
    --project="$GCP_PROJECT_ID" \
    --filter="displayName=\\\"$display_name\\\"" \
    --format='value(name)' | head -n 1)"
  if [ -n "$policy_name" ]; then
    gcloud monitoring policies update "$policy_name" \
      --project="$GCP_PROJECT_ID" \
      --policy-from-file="$policy_file"
  else
    gcloud monitoring policies create \
      --project="$GCP_PROJECT_ID" \
      --policy-from-file="$policy_file"
  fi
}

apply_policy observability/dead-letter-policy.json \
  'Studium dead-lettered jobs'
apply_policy observability/refresh-failure-policy.json \
  'Studium opportunity refresh failures'

dashboard_id="$(gcloud monitoring dashboards list \
  --project="$GCP_PROJECT_ID" \
  --filter='displayName="Studium backend operations"' \
  --format='value(name)' | head -n 1)"
if [ -n "$dashboard_id" ]; then
  gcloud monitoring dashboards update "$dashboard_id" \
    --project="$GCP_PROJECT_ID" \
    --config-from-file=observability/dashboard.json
else
  gcloud monitoring dashboards create \
    --project="$GCP_PROJECT_ID" \
    --config-from-file=observability/dashboard.json
fi
