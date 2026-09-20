terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
    backend "s3" {
    bucket         = "vaibhav-parte-state-lock-demo"
    key            = "workload/terraform.tfstate"
    region         = "ap-south-1"
    use_lockfile     = true 
    }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}
