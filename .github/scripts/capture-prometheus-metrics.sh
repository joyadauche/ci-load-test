set -e
kubectl get svc --namespace monitoring
kubectl port-forward svc/kube-prometheus-stack-prometheus 9090:9090 --namespace monitoring --kubeconfig ~/.kube/config & 
while ! nc -z localhost 9090; do
    sleep 1
done
curl -sS "http://localhost:9090/api/v1/query\?query\=node_load5"
# ps aux | grep 9090
# result=$(ps aux | grep 9090 | awk '{print $2}' | tr '\n' ', ' | sed 's/, $//')
# echo "Process Ids: $result"
# for process_id in $(echo $result | sed "s/,/ /g")
# do
#     sudo kill -9 $process_id
# done
