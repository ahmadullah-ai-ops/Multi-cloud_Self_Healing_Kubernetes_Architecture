# Makefile for Multi-cloud Self Healing Kubernetes Architecture

deploy-aws:
	terraform -chdir=aws init && terraform -chdir=aws apply -auto-approve

deploy-azure:
	terraform -chdir=azure init && terraform -chdir=azure apply -auto-approve

destroy-aws:
	terraform -chdir=aws destroy -auto-approve

destroy-azure:
	terraform -chdir=azure destroy -auto-approve

deploy-k8s:
	kubectl apply -f k8s/base/
	kubectl apply -f k8s/self-healer/

destroy-k8s:
	kubectl delete -f k8s/base/
	kubectl delete -f k8s/self-healer/
