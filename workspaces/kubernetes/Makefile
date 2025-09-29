.PHONY: init plan refresh apply

init:
	terraform init

_prepare:
	mkdir -p ../../tmp/kubernetes
	cat ../../vars/common.tfvars ../../vars/kubernetes.tfvars > ../../tmp/kubernetes/env.tfvars

_plan:
	@echo
	@echo "========"
	cat ../../tmp/kubernetes/env.tfvars
	@echo
	@echo "========"
	@echo
	terraform plan -var-file=../../tmp/kubernetes/env.tfvars -out=../../tmp/kubernetes/plan.tfplan

_destroy:
	terraform destroy -var-file=../../tmp/kubernetes/env.tfvars 


plan: _prepare _plan

destroy: _prepare _destroy

refresh:
	terraform refresh -var-file=../../tmp/kubernetes/env.tfvars

apply:
	terraform apply ../../tmp/kubernetes/plan.tfplan

refresh:
	terraform refresh -var-file=../../tmp/kubernetes/env.tfvars

all: init plan apply
