#
# Makefile
#

all: init plan apply

init:
	terraform init

update:
	terraform get -update

plan: update
	terraform plan -var-file config.tfvars -out terraform.tfplan

apply:
	terraform apply -auto-approve -var-file config.tfvars

destroy:
	terraform plan -destroy -var-file config.tfvars -out terraform.tfplan
	terraform apply terraform.tfplan

ssh:
	chmod 400 generated/ssh/deployer
	ssh -o IdentitiesOnly=yes -i generated/ssh/deployer hadoop@$$(terraform output emr_main_address)

clean:
	rm -rf terraform.tfplan terraform.tfstate* generated/ rendered/


.PHONY: all init update plan apply destroy ssh clean
