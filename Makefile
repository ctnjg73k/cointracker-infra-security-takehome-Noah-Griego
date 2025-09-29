SHELL := /bin/bash
_core_.init:
	cd workspaces/${PROJECT} && make init

_core_.plan:
	cd workspaces/${PROJECT} && make plan

_core_.apply:
	cd workspaces/${PROJECT} && make apply

_core_.destroy:
	cd workspaces/${PROJECT} && make destroy

_core_.all:
	cd workspaces/${PROJECT} && make all

kubernetes.%: PROJECT = kubernetes
kubernetes.init: _core_.init
kubernetes.plan: _core_.plan
kubernetes.apply: _core_.apply
kubernetes.destroy: _core_.destroy
kubernetes.all: _core_.all

database.%: PROJECT = database
database.init: _core_.init
database.plan: _core_.plan
database.apply: _core_.apply
database.destroy: _core_.destroy
database.all: _core_.all

clean: 
	terraform fmt -recursive .
