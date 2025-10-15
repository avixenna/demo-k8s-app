#!/bin/bash
set -e

# === CONFIGURATIONS ===
APP_NAME="demo-kejagung"
DEPLOYMENT_NAME="demo-kejagung"
REGISTRY="127.0.0.1:5000"
TARGET_REGISTRY="192.168.59.1:5000"
KUBECONFIG=".kube/config"
NAMESPACE="ns-kejagung"

# === PESERTA ===
PESERTA="xna"  # ubah sesuai nama peserta
IMAGE_TAG="$(date +%Y%m%d%H%M%S)-${PESERTA}"

# === BUILD IMAGE ===
echo "🐳 Building image ${APP_NAME}:${IMAGE_TAG}..."
docker build -t ${REGISTRY}/${APP_NAME}:${IMAGE_TAG} .

# === PUSH IMAGE TO LOCAL REGISTRY ===
echo "📦 Pushing image to local registry..."
docker push ${REGISTRY}/${APP_NAME}:${IMAGE_TAG}

# === ENSURE NAMESPACE ===
if ! kubectl --kubeconfig=${KUBECONFIG} get ns ${NAMESPACE} >/dev/null 2>&1; then
  echo "🧱 Creating namespace ${NAMESPACE}..."
  kubectl --kubeconfig=${KUBECONFIG} apply -f k8s/namespace.yaml
fi

# === DEPLOY TO RKE2 ===
echo "☸️  Deploying to RKE2..."
kubectl --kubeconfig=${KUBECONFIG} -n ${NAMESPACE} set image deployment/${DEPLOYMENT_NAME} ${DEPLOYMENT_NAME}=${TARGET_REGISTRY}/${APP_NAME}:${IMAGE_TAG} --record || \
kubectl --kubeconfig=${KUBECONFIG} -n ${NAMESPACE} apply -f k8s/

echo "✅ Deployment complete!"
kubectl --kubeconfig=${KUBECONFIG} -n ${NAMESPACE} get pods -l app=${DEPLOYMENT_NAME}
