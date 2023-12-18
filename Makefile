all:

ping-aws:  # ensure using Admin user and REGION set
	aws sts get-caller-identity | grep 'user/admin"'
	@env | grep AWS_REGION

plan: ping-aws
	terraform -chdir=tf-setup plan 

auto-apply: ping-aws ## Apply terraform automatically -- DANGEROUS
	terraform -chdir=tf-setup apply -auto-approve
