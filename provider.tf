# Terraform configuration block (required for provider versions).
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"  # Stable version as of 2025; supports your resources.
    }
  }
  required_version = ">= 1.0.0, <= 1.4.0"  # Matches your workflow.
}

# AWS provider configuration.
provider "aws" {
  region = "us-east-1"  # Change to your region (e.g., us-east-1); must match bucket.

  # Optional: If not using OIDC, add default_tags or assume_role here.
  # For OIDC, this is auto-configured in the workflow.
}