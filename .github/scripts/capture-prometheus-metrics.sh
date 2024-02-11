set -e
kubectl port-forward svc/kube-prometheus-stack-prometheus 9090:9090 --namespace monitoring --kubeconfig ~/.kube/config & 
while ! nc -z localhost 9090; do
    sleep 1
done
curl -sS "http://localhost:9090/api/v1/query\?query\=node_load5"
