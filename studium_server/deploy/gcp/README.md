# GCP deployment

`deploy-cloud-run.sh` deploys three runtime pieces from one immutable image:

- `studium-api` as the public Serverpod API service;
- `studium-insights` as the private operational insights service boundary;
- `studium-worker` as a bounded Cloud Run Job invoked by Cloud Scheduler.

The worker job sets `STUDIUM_WORKER_ONCE=true`, processes one durable queue
batch, and exits. PostgreSQL claim locks make overlapping or retried scheduler
invocations safe. The scheduler uses an OAuth service account and the worker
job has no public HTTP endpoint.

Required deployment variables/secrets:

```text
GCP_PROJECT_ID
GCP_REGION
GCP_IMAGE
GCP_DATABASE_INSTANCE
GCP_RUNTIME_SERVICE_ACCOUNT
GCP_WORKER_INVOKER_SERVICE_ACCOUNT
GCP_PASSWORDS_SECRET
```

Optional variables include `GCP_RUNMODE`, `GCP_WORKER_SCHEDULE`,
`GCP_WORKER_TIME_ZONE`, and the service/job names. Application credentials
must be supplied through the deployment platform's secret mechanism; do not
put production values in `config/passwords.yaml` or the container image.
`GCP_PASSWORDS_SECRET` must reference a Secret Manager value containing the
base64-encoded `passwords.yaml`; the container materializes it only at
startup.

The repository deployment workflow only runs this script when the
`GCP_DEPLOY_ENABLED` repository variable is explicitly set to `true`.

After deployment, run `configure-observability.sh` with
`GCP_PROJECT_ID` and a Monitoring notification-channel resource name in
`GCP_NOTIFICATION_CHANNEL`. It creates or updates log-based metrics, alert
policies, and a backend operations dashboard without duplicating resources.
