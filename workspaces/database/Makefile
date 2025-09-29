.PHONY: init plan refresh apply

init:
	terraform init

_prepare:
	mkdir -p ../../tmp/database
	cat ../../vars/common.tfvars ../../vars/database.tfvars > ../../tmp/database/env.tfvars

_plan:
	@echo
	@echo "========"
	cat ../../tmp/database/env.tfvars
	@echo
	@echo "========"
	@echo
	terraform plan -var-file=../../tmp/database/env.tfvars -out=../../tmp/database/plan.tfplan

_destroy:
	terraform destroy -var-file=../../tmp/database/env.tfvars 


plan: _prepare _plan

destroy: _prepare _destroy

refresh:
	terraform refresh -var-file=../../tmp/database/env.tfvars

apply:
	terraform apply ../../tmp/database/plan.tfplan

refresh:
	terraform refresh -var-file=../../tmp/database/env.tfvars

all: init plan apply
