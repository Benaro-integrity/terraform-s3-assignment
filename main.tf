# 1. Define the cloud provider and region
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-West-2" # Replace with your preferred AWS region
}

# 2. Create the S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket        = "my-unique-jenkins-terraform-bucket-2026" # S3 names MUST be globally unique
  force_destroy = true                                      # Allows Terraform to delete the bucket even if it contains files

  tags = {
    Name        = "Jenkins Managed Bucket"
    Environment = "Dev"
  }
}

# 3. Enable Versioning (Best practice to keep file history)
resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.my_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# 4. Enable Server-Side Encryption (Best practice for security)
resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_crypto" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# 5. Block all public access (Best practice to avoid data leaks)
resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
