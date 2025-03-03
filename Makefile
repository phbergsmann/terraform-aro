.DEFAULT_GOAL := create

init:
	terraform init

create: init
	terraform plan -out aro.plan 		\
		-var "cluster_name=aro-${USER}" \
		-var "pull_secret_path=~/Downloads/pull-secret.json"
	terraform apply aro.plan

create-private: init
	terraform plan -out aro.plan 		\
		-var "cluster_name=aro-${USER}" \
		-var "restrict_egress_traffic=true"		\
		-var "aro_private=true" \
		-var "pull_secret_path=~/Downloads/pull-secret.json"

	terraform apply aro.plan

create-private-noegress: init
	terraform plan -out aro.plan 		\
		-var "cluster_name=aro-${USER}" \
		-var "restrict_egress_traffic=false"		\
		-var "aro_private=true" \
		-var "pull_secret_path=~/Downloads/pull-secret.json"

	terraform apply aro.plan

destroy:
	terraform destroy

destroy.force:
	terraform destroy -auto-approve

delete: destroy

help:
	@echo make [create|destroy]
