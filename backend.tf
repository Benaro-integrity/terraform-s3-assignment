/*This my tf comment */
terraform {
  backend "s3" {
    bucket = "my-completely-unique-bucket-name-2026"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }
}