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

# Building Multi-Environment AWS Infrastructure with Terraform: A Story of Consistency, Control, and Confidence

## The Challenge Every Cloud Engineer Faces

If you’ve ever managed cloud infrastructure manually—or even semi-automated with console clicks-you’ve probably felt it: that quiet fear of *“Did I configure everything the same way in staging and production?”*

It’s the same uncertainty that creeps in when a single change breaks production but works fine in development. Every DevOps engineer, cloud architect, or system administrator knows the frustration of inconsistency across environments, different instance types, misaligned configurations, or forgotten tags.

That’s where Infrastructure as Code (IaC) changes everything. But the truth is, not every IaC setup is built for **clarity, scalability, and trust**. That’s why I built this project, a **Multi-Environment AWS Infrastructure with Terraform**, to show how to achieve all three.

---

## The Story Behind the Project

I started this project with a question:
**“How can I make AWS infrastructure predictable, modular, and secure, no matter how many environments I run?”**

Most teams begin with a single environment, usually development. It works fine until staging and production arrive, and suddenly, the same Terraform scripts start to feel messy. Different instance sizes, security rules, and AMIs make everything harder to manage.

So I built this project with one principle:
**“Every environment should feel unique, but be governed by the same blueprint.”**

And Terraform gave me that power.

---

## Step 1: Teaching Terraform to Talk to AWS

The journey began by teaching Terraform to communicate with AWS securely.

I defined the provider and version controls, ensuring every engineer running the same configuration would get the same results, reproducible, traceable, and future-proof.

This might sound simple, but version locking is one of the most overlooked steps in IaC. Without it, even small provider updates can break your workflow. Here, stability became non-negotiable.

---

## Step 2: The Modular Architecture Approach of Reuse, Don’t Repeat

Next came structure.

I divided the project into two main parts:

1. **Core Files** : global configurations and resources.
2. **Modules** : reusable blueprints for AWS services like EC2, S3, and DynamoDB.

Each module behaves like a self-contained system. Whether it’s spinning up compute power, creating secure storage, or managing databases, the modules stay consistent while parameters like region, size, or scaling can vary across environments.

This separation isn’t just organizational—it’s a form of control. In real DevOps environments, modularity prevents chaos. You update one piece, and it ripples safely through every environment.

---

## Step 3: Multi-Environment Deployment

Now came the most satisfying part **multi-environment deployment**.

I created three distinct setups:

* **Development:** Light and experimental (t2.micro).
* **Staging:** Balanced for testing (t2.medium).
* **Production:** Scalable and resilient (t2.large).

All three environments use the *same core logic* but adapt through variables and modules.
It’s like having three homes built from one architectural plan, each customized, but all structurally identical.

This consistency eliminates a common pain point: the “it worked in staging but not in prod” dilemma.

---

## Step 4: Security and Trust

You can’t talk about infrastructure without talking about security.

I implemented key pairs for EC2 instances, custom security groups for controlled SSH access, and isolated each environment to avoid cross-impact.
This design reflects a mindset: *security isn’t an afterthought; it’s the default.*

Every system that touches production should be protected by design, not by patch.

---

## Step 5: Output and Visibility

In real operations, visibility is confidence.
That’s why I included structured output configurations, showing crucial deployment information like public IPs and resource IDs after each apply.

Too often, teams build infrastructure and lose track of what’s actually live. Clear outputs are not just convenience, they are accountability.

---

## Step 6: The Human Element

This project isn’t only about Terraform or AWS. It’s about **engineering confidence**.

When environments drift apart, developers lose trust.
When automation fails silently, managers lose control.
When deployments take longer than discussions, leadership loses patience.

Infrastructure as Code, when designed properly, brings all these elements back together. It creates a culture of reliability where every line of configuration serves a purpose, and every environment tells the same story.

---

## What You Can Learn from This

If you’re a cloud engineer or DevOps professional, here are the deeper lessons this project reinforces:

1. **Consistency is greater than speed.** Always automate with repeatability in mind.
2. **Modularity is power.** Reusable design keeps your infrastructure scalable.
3. **Security is structure.** The most secure environments are those architected, not added.
4. **Visibility builds trust.** Every successful deployment should end with clarity.
5. **Automation without design is noise.** Terraform is a tool; architecture is the discipline.

---

## The Bigger Picture

This project represents a small yet powerful step toward **predictable cloud infrastructure**.
Whether you manage startups or enterprise workloads, the principles remain the same, build once, reuse forever, and trust your automation.

It’s more than Terraform commands; it’s about **building systems you can sleep well with**.

And that’s the real victory of Infrastructure as Code, not just automation, but assurance.

---

## Final Thoughts

Multi-Environment AWS Infrastructure with Terraform isn’t just a demo.
It’s a mindset shift, from chaos to clarity, from repetition to reuse, and from fear to confidence.

The real magic lies not in the code itself, but in the philosophy behind it:
**Build it once. Build it right. Deploy it everywhere.**

