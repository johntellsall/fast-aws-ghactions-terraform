all:

ping-aws:  # ensure using Admin user and REGION set
	aws sts get-caller-identity | grep 'user/admin"'
	@env | grep --silent AWS_REGION

plan: ping-aws
	terraform plan 

auto-apply: ping-aws ## Apply terraform automatically -- DANGEROUS
	terraform apply -auto-approve

# display file from S3 bucket johntellsall-202312-tf-state key    = "state/terraform.tfstate"
show-remote-state: ping-aws
	aws s3 ls johntellsall-202312-tf-state
	aws s3api get-object --bucket johntellsall-202312-tf-state --key state/terraform.tfstate /dev/stdout
# plan: ping-aws
# 	terraform -chdir=tf-setup plan 

# auto-apply: ping-aws ## Apply terraform automatically -- DANGEROUS
# 	terraform -chdir=tf-setup apply -auto-approve

format:
	terraform fmt -recursive

validate:
	terraform -chdir=tf-setup validate