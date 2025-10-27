# Self-Healing Mechanism

This component ensures Kubernetes workloads recover automatically in case of failures.

## How it works
- A **CronJob** runs periodically.
- It executes a script `check_and_repair.sh` that:
  - Checks for unhealthy Pods or Deployments.
  - Restarts or scales them as needed.

## Files
- `self-healer-cronjob.yaml` — defines the job.
- `scripts/check_and_repair.sh` — repair logic.

Example log output:
```
[INFO] Checking for unhealthy pods...
[FIXED] Restarted pod nginx-deployment-abc123
```
