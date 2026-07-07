terraform {
  backend "s3" {
    bucket = "my-completely-unique-bucket-name-2026"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}