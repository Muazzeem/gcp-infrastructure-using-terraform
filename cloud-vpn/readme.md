# AWS-GCP Hybrid Cloud VPN Configuration

This directory contains Terraform configuration for setting up a hybrid cloud VPN connection between AWS and Google Cloud Platform.

## Configuration Files

### main.tf
This file defines two main Terraform modules:

1. **Transit Gateway (AWS)**
   - **Module**: terraform-aws-modules/transit-gateway/aws
   - **Version**: 1.1.0
   - **Name**: tgw-example-us-east-1
   - **ASN**: 64512
   - **Features**:
     - Auto-accept shared attachments enabled
     - RAM external principals allowed
   - **Purpose**: Shared TGW for multiple AWS accounts

2. **Hybrid Cloud VPN (AWS-GCP)**
   - **Module**: spotify/terraform-google-aws-hybrid-cloud-vpn
   - **Configuration**:
     - Connected to AWS Transit Gateway
     - Uses default Google network
     - AWS ASN: 64512
     - Google ASN: 65534

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

- AWS CLI configured with appropriate credentials
- Google Cloud SDK installed and configured
- Terraform installed (version 0.12 or later)
- Appropriate permissions in both AWS and GCP
