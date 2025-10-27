# Setting up Jenkins credentials for the pipeline

This file shows recommended steps to add the kubeconfig files and any cloud secrets into Jenkins Credentials (example using Jenkins UI).

1. Prepare kubeconfig files:
   - After running `terraform apply`, extract kubeconfigs into a secure folder (see `scripts/extract-kubeconfigs.sh`).
   - You should have:
     - `kubeconfig-eks.yaml`
     - `kubeconfig-aks.yaml`

2. Create Jenkins credentials (type: "Secret file"):
   - ID: `eks_kubeconfig`
     - Upload file: `kubeconfig-eks.yaml`
   - ID: `aks_kubeconfig`
     - Upload file: `kubeconfig-aks.yaml`

3. Add cloud provider secrets:
   - For AWS: Use "AWS Credentials" plugin or add env creds as "Username with password" or "Secret text".
   - For Azure: use Service Principal client id/secret as "Secret text" or use Azure Credentials plugin.

4. Jenkinsfile expects these credential IDs:
   - `eks_kubeconfig`
   - `aks_kubeconfig`

5. Secure the Jenkins instance:
   - Limit which users can read credentials.
   - Use Jenkins agents within your network that have kubectl, terraform, and cloud CLIs installed.

6. Use Vault or your cloud KMS to store kubeconfigs and inject them into the build instead of storing in Jenkins.