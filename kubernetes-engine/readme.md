# Kubernetes Engine Configuration

This directory contains Terraform configuration for Google Kubernetes Engine (GKE) and workload identity setup.

## Configuration Files

### main.tf
This file contains the main Terraform configuration:

1. **Backend Configuration**
   - Uses Google Cloud Storage bucket "saifuls-playground"
   - State file prefix: "sate-files/kubernetes-engine"

2. **Google Cloud Provider**
   - Project: your-project-id
   - Region: us-central1
   - Zone: us-central1-c

3. **Kubernetes Service Account**
   - Name: my-application-name
   - Namespace: default
   - Configured with GCP service account annotation
   - Service account: my-application-name@your-project-id.iam.gserviceaccount.com

4. **Workload Identity Module**
   - Source: terraform-google-modules/kubernetes-engine/google//modules/workload-identity
   - Name: my-application-name
   - Uses existing Kubernetes service account
   - Project ID: your-project-id

## Outputs

- `k8s_service_account_name`: Name of the created Kubernetes service account

## Usage Instructions

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Review the planned changes:
   ```bash
   terraform plan
   ```

3. Apply the configuration:
   ```bash
   terraform apply
   ```

4. To destroy the infrastructure:
   ```bash
   terraform destroy
   ```

## Prerequisites

- Google Cloud SDK installed and configured
- Terraform installed (version 0.12 or later)
- Appropriate GCP permissions
- Access to target GKE cluster
