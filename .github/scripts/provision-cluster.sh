set -e
cd ./terraform/
terraform initt
terraform validate
terraform plan
terraform apply -auto-approve