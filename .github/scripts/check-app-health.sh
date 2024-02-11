set -e
sleep 15s

# check ingress controller
result=$(kubectl get pods -n ingress-nginx -l app.kubernetes.io/name=ingress-nginx -o json | jq -r '.items[].status.phase')
echo "Ingress Controller Status: $result"
if [[ "${result}" != "Running" ]]; then
  exit 1
fi

# check app pods
result=$(kubectl get pods -n echoserver  -o json | jq -r '.items[].status.phase' | tr '\n' ', ' | sed 's/, $//') 
echo "App Pods Status: $result"
for i in $(echo $variable | sed "s/,/ /g")
do
    if [[ "${result}" != "Running" ]]; then
     exit 1
    fi
done

# check ingress http call
hosts=$(kubectl get ingress -n echoserver | awk 'NR>1 {print $3}')
echo $hosts # foo.localhost,bar.localhost
for host in $(echo $hosts | sed "s/,/ /g")
do
    echo $host
    curl $host
    curl http://$host

    exit_status="${?}"
    if [[ "${exit_status}" -ne 0 ]]; then
      exit 1
    fi
done