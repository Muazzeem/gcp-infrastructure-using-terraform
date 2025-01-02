# Serverless Load Balancing Configuration

This directory contains Terraform configuration for deploying serverless load balancing with Cloud Run on Google Cloud Platform.

## Configuration Files

### main.tf
This file contains the main Terraform configuration:

1. **Backend Configuration**
   - Uses Google Cloud Storage bucket "your-bucket-name"
   - State file prefix: "sate-files/sls-load-balancing"

2. **Google Cloud Provider**
   - Project: your-project-id
   - Region: us-central1
   - Zone: us-central1-c

3. **Cloud Run Service**
   - Name: hello
   - Uses default "hello world" container image
   - Public access enabled via IAM member binding

4. **Load Balancing Components**
   - Global IP address reservation
   - Managed SSL certificate for custom domain
   - Serverless Network Endpoint Group (NEG)
   - Backend service configuration for the load balancer

## Usage Instructions

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Review the planned changes:
   ```bash
   terraform plan -var="project=your-project-id" -var="domain=your-domain.com"
   ```

3. Apply the configuration:
   ```bash
   terraform apply -var="project=your-project-id" -var="domain=your-domain.com"
   ```

4. To destroy the infrastructure:
   ```bash
   terraform destroy -var="project=your-project-id" -var="domain=your-domain.com"
   ```

## Required Variables

- `project`: The GCP project ID where resources will be deployed
- `region`: The region to deploy resources (default: us-central1)
- `name`: Base name for resources (default: default)
- `domain`: Custom domain for SSL certificate

## Prerequisites

- Google Cloud SDK installed and configured
- Terraform installed (version 0.12 or later)
- Appropriate GCP permissions
- Custom domain ownership verified in Google Cloud Console
- Default VPC network exists in project

## Architecture

This configuration sets up serverless load balancing for a Cloud Run service by:
1. Deploying a Cloud Run service with a sample application
2. Creating a global IP address for the load balancer
3. Provisioning a managed SSL certificate for secure connections
4. Setting up a serverless NEG to connect the load balancer to Cloud Run
5. Configuring the backend service for the load balancer

This setup enables:
- Global load balancing
- SSL/TLS termination
- Custom domain support
- Automatic scaling of Cloud Run instances

