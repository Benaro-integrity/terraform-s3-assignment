# Configure the Terraform block and require the AWS provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0.0"
}

# Define the AWS Provider and target region
provider "aws" {
  region = "eu-west-2"
}

# Create the S3 Bucket resource
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-completely-unique-bucket-name-2026" # Must be globally unique across all AWS accounts

  tags = {
    Name        = "My Terraform Bucket"
    Environment = "Dev"
  }
}