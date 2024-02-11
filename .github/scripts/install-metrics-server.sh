# install metrics server
helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
helm upgrade --install metrics-server metrics-server/metrics-server
result=$(kubectl get pods -n kube-system | grep metrics-server | awk 'NR==1')
echo "Metrics Server Pods Status: $result"
if [[ "${result}" == "Running" ]]; then
  helm upgrade metrics-server metrics-server/metrics-server --set args="{--kubelet-insecure-tls}" -n kube-system
fi
