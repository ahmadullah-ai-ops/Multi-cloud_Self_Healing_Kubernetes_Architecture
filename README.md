# Multi-cloud Self Healing Kubernetes Architecture

Repository purpose
- Provision Kubernetes clusters on **AWS (EKS)** and **Azure (AKS)** using Terraform.
- Deploy a demo microservice (`nginx:stable`) to both clusters.
- Provide a **self-healer** (Kubernetes CronJob) that checks application health and restarts/rolls deployments if unhealthy.
- CI/CD via **Jenkins**: runs Terraform, deploys k8s manifests, monitors health, and triggers self-heal actions if required.

Important
- This repo is a demo/boilerplate. You must provide cloud credentials and adjust variables before running your own.
- The demo app uses `nginx:stable` --- no image build required.

Quick Workflow
1. Set cloud credentials (AWS & Azure).
2. `cd terraform && terraform init && terraform apply` (see variables).
3. Configure kubeconfigs (outputs will show how).
4. Run `kubectl apply -f k8s/base/` on both clusters (or let the Jenkins do it).
5. Install Jenkins and configure pipeline using `jenkins/Jenkinsfile`.
6. Monitor self-healer CronJob in each cluster.

Contents
- `terraform/` : infra code for EKS (terraform-aws-modules recommended) and AKS (azurerm).
- `k8s/` : manifests for nginx:stable deployment + HPA + self-healer CronJob.
- `jenkins/` : Jenkinsfile for CI/CD.

Notes on self-healing design
- Uses native Kubernetes features (liveness/readiness probes, HPA, PDB).
- Adds a CronJob that runs a lightweight script to check app endpoints and perform `kubectl rollout restart` or scale operations if unhealthy.
- Jenkins pipeline orchestrates terraform -> apply manifests -> verify -> force redeploy.

Security & Production considerations
- Use secure secret storage for kubeconfigs (Jenkins credentials store / vault).
- For global traffic failover in production use a managed/global load balancer (e.g., Route 53 with health checks or cloud traffic manager).
- Use private clusters, RBAC, and network policies for hardening.

See examples/terraform.tfvars.example and scripts/setup-jenkins-credentials-example.md for setup hints.



