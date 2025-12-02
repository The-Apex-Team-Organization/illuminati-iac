.PHONY: init plan apply destroy

BIRD_ENV=dev-01

init:
	terraform init -backend-config="./backends/${BIRD_ENV}.tfbackend"
	terraform workspace select -or-create ${BIRD_ENV}

plan: init
	terraform plan -var-file=workspace_vars/${BIRD_ENV}.tfvars

apply: init
	terraform apply -var-file=workspace_vars/${BIRD_ENV}.tfvars -auto-approve

destroy: init
	terraform destroy -var-file=workspace_vars/${BIRD_ENV}.tfvars -auto-approve
