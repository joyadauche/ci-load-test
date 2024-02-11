# install metrics server
helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
helm upgrade --install metrics-server metrics-server/metrics-server
sleep 15s
helm upgrade metrics-server metrics-server/metrics-server --set args="{--kubelet-insecure-tls}" -n kube-system