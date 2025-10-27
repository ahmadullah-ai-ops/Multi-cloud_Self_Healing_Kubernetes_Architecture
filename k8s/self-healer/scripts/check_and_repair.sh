#!/bin/sh
# Simple self-heal script:
# - check if pods are Ready
# - if not, restart the deployment (rollout restart)
# - optionally scale up temporarily

NAMESPACE=demo-app
DEPLOYMENT=nginx-demo
MIN_READY=1

NOT_READY=$(kubectl get pods -n ${NAMESPACE} -l app=${DEPLOYMENT} -o jsonpath='{.items[*].status.conditions[?(@.type=="Ready")].status}' | grep -c "False" || true)

if [ -n "$NOT_READY" ] && [ "$NOT_READY" -gt 0 ]; then
  echo "[self-healer] Found ${NOT_READY} not-ready pods. Rolling restart deployment ${DEPLOYMENT}"
  kubectl -n ${NAMESPACE} rollout restart deploy ${DEPLOYMENT}
  # wait then check again
  sleep 20
  kubectl -n ${NAMESPACE} rollout status deploy ${DEPLOYMENT} --timeout=120s || echo "[self-healer] Rollout did not converge"
else
  echo "[self-healer] All pods are ready"
fi

# also verify service endpoint with curl from cluster
# run a short port-forward or run curl against cluster IP using busybox if needed