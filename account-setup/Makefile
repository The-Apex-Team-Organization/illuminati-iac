.PHONY: init plan apply destroy bootstrap
ENV=dev-01

#this step will create S3 buket for backends
bootstrap:
	cd ./terraform_state && \
	terraform init && \
	terraform apply -var-file="../account_vars/${ENV}.tfvars" -auto-approve

init:
	terraform init -backend-config="./backends/${ENV}.tfbackend" -reconfigure

plan: init
	terraform plan -var-file="./account_vars/${ENV}.tfvars"

apply: init
	terraform apply -var-file="./account_vars/${ENV}.tfvars" -auto-approve

destroy: init
	terraform destroy -var-file="./account_vars/${ENV}.tfvars" -auto-approve