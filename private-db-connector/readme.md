# Private Database Connector Configuration

This directory contains Terraform configuration for deploying a private database connector on Google Cloud Platform.

## Configuration Files

### main.tf
This file contains the main Terraform configuration:

1. **Backend Configuration**
   - Uses Google Cloud Storage bucket "your-bucket-name"
   - State file prefix: "sate-files/private-db-connector"

2. **Google Cloud Provider**
   - Project: your-project-id
   - Region: us-central1
   - Zone: us-central1-c

3. **VPC Access Connector**
   - Name: serverless-vpc-connector
   - Uses default network
   - IP CIDR range: 10.8.0.0/28

4. **Cloud SQL Instance**
   - Private PostgreSQL 14 instance
   - Region: us-central1
   - Tier: db-f1-micro
   - Features:
     - Private IP only (no public IP)
     - Connected to default VPC network
     - Random suffix added to instance name

## Usage Instructions

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Review the planned changes:
   ```bash
   terraform plan -var="project=your-project-id" -var="db_pass=your-db-password"
   ```

3. Apply the configuration:
   ```bash
   terraform apply -var="project=your-project-id" -var="db_pass=your-db-password"
   ```

4. To destroy the infrastructure:
   ```bash
   terraform destroy -var="project=your-project-id" -var="db_pass=your-db-password"
   ```

## Required Variables

- `project`: The GCP project ID where resources will be deployed
- `db_pass`: Root password for the database instance

## Prerequisites

- Google Cloud SDK installed and configured
- Terraform installed (version 0.12 or later)
- Appropriate GCP permissions
- Default VPC network exists in project
