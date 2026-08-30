#!/usr/bin/env bash
set -euo pipefail

# Deploys the API/Insights services and a bounded worker Cloud Run Job. The
# job is invoked by Cloud Scheduler, so durable PostgreSQL queue state remains
# the source of truth and multiple invocations are safe.

: "${GCP_PROJECT_ID:?Set GCP_PROJECT_ID}"
: "${GCP_REGION:?Set GCP_REGION}"
: "${GCP_IMAGE:?Set GCP_IMAGE to the pushed image reference}"
: "${GCP_DATABASE_INSTANCE:?Set GCP_DATABASE_INSTANCE to the Cloud SQL connection name}"
: "${GCP_RUNTIME_SERVICE_ACCOUNT:?Set GCP_RUNTIME_SERVICE_ACCOUNT}"
: "${GCP_WORKER_INVOKER_SERVICE_ACCOUNT:?Set GCP_WORKER_INVOKER_SERVICE_ACCOUNT}"
: "${GCP_PASSWORDS_SECRET:?Set GCP_PASSWORDS_SECRET to the Secret Manager secret name containing base64-encoded passwords.yaml}"

RUNMODE="${GCP_RUNMODE:-production}"
API_SERVICE="${GCP_API_SERVICE:-studium-api}"
INSIGHTS_SERVICE="${GCP_INSIGHTS_SERVICE:-studium-insights}"
WORKER_JOB="${GCP_WORKER_JOB:-studium-worker}"
SCHEDULER_JOB="${GCP_SCHEDULER_JOB:-studium-worker-schedule}"
WORKER_SCHEDULE="${GCP_WORKER_SCHEDULE:-*/5 * * * *}"
WORKER_TIME_ZONE="${GCP_WORKER_TIME_ZONE:-UTC}"

common_args=(
  --project="$GCP_PROJECT_ID"
  --region="$GCP_REGION"
  --image="$GCP_IMAGE"
  --service-account="$GCP_RUNTIME_SERVICE_ACCOUNT"
  --set-cloudsql-instances="$GCP_DATABASE_INSTANCE"
  --set-env-vars="runmode=$RUNMODE,role=serverless"
  --set-secrets="SERVERPOD_PASSWORDS_B64=$GCP_PASSWORDS_SECRET:latest"
  --execution-environment=gen2
)

gcloud run deploy "$API_SERVICE" "${common_args[@]}" \
  --port=8080 \
  --allow-unauthenticated

gcloud run deploy "$INSIGHTS_SERVICE" "${common_args[@]}" \
  --port=8081 \
  --no-allow-unauthenticated

gcloud run jobs deploy "$WORKER_JOB" \
  --project="$GCP_PROJECT_ID" \
  --region="$GCP_REGION" \
  --image="$GCP_IMAGE" \
  --service-account="$GCP_RUNTIME_SERVICE_ACCOUNT" \
  --set-cloudsql-instances="$GCP_DATABASE_INSTANCE" \
  --set-env-vars="runmode=$RUNMODE,role=worker,STUDIUM_WORKER_ONCE=true" \
  --set-secrets="SERVERPOD_PASSWORDS_B64=$GCP_PASSWORDS_SECRET:latest" \
  --tasks=1 \
  --max-retries=2 \
  --task-timeout=900s

WORKER_RUN_URI="https://run.googleapis.com/apis/run.googleapis.com/v1/projects/$GCP_PROJECT_ID/locations/$GCP_REGION/jobs/$WORKER_JOB:run"
if gcloud scheduler jobs describe "$SCHEDULER_JOB" \
  --project="$GCP_PROJECT_ID" \
  --location="$GCP_REGION" >/dev/null 2>&1; then
  gcloud scheduler jobs update http "$SCHEDULER_JOB" \
    --project="$GCP_PROJECT_ID" \
    --location="$GCP_REGION" \
    --schedule="$WORKER_SCHEDULE" \
    --time-zone="$WORKER_TIME_ZONE" \
    --uri="$WORKER_RUN_URI" \
    --http-method=POST \
    --oauth-service-account-email="$GCP_WORKER_INVOKER_SERVICE_ACCOUNT"
else
  gcloud scheduler jobs create http "$SCHEDULER_JOB" \
    --project="$GCP_PROJECT_ID" \
    --location="$GCP_REGION" \
    --schedule="$WORKER_SCHEDULE" \
    --time-zone="$WORKER_TIME_ZONE" \
    --uri="$WORKER_RUN_URI" \
    --http-method=POST \
    --oauth-service-account-email="$GCP_WORKER_INVOKER_SERVICE_ACCOUNT"
fi
