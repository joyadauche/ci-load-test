cd ./terraform/
terraform init
terraform validate
terraform plan
terraform apply -auto-approvee
TERRAFORM_APPLY_EXIT_STATUS="${?}"
if [[ "${TERRAFORM_APPLY_EXIT_STATUS}" -ne 0 ]]
then
    exit 1
fi