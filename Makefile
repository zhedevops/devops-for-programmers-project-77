new_iam_token:
	yc iam create-token | awk '{print "yc_iam_token = \""$1"\""}' > secret.autofile.tfvars

tf-init:
	terraform -chdir=./terraform/ init

tf-init-migrate-state:
	terraform -chdir=./terraform/ init -migrate-state

tf-reconfigure:
	terraform -chdir=./terraform/ init -reconfigure

tf-plan:
	terraform -chdir=./terraform/ plan

tf-apply:
	terraform -chdir=./terraform/ apply

tf-destroy:
	terraform -chdir=./terraform/ destroy
