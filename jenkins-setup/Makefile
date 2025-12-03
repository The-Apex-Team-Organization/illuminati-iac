.PHONY: init plan apply destroy 
ENV=stage-01


init:
	terraform init -backend-config="./backend/${ENV}.tfbackend" -reconfigure

plan: init
	terraform plan -var-file="./workspace_vars/${ENV}.tfvars"

apply: init
	terraform apply -var-file="./workspace_vars/${ENV}.tfvars" -auto-approve

destroy: init
	terraform destroy -var-file="./workspace_vars/${ENV}.tfvars" -auto-approve