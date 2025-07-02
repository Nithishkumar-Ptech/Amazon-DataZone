terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.38.0"  # Ensure DataZone support
    }
  }

  required_version = ">= 1.4.0"  # Adjust based on your Terraform CLI version
}

