terragrunt plan-all  --terragrunt-non-interactive  --terragrunt-working-dir deploy/vpc
sleep 5
terragrunt plan-all  --terragrunt-non-interactive  --terragrunt-working-dir deploy/test-vm-1
