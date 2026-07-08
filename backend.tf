terraform {
  backend "s3" {
    bucket  = "jenkins-terraform-s3-2026"
    key     = "s3-bucket-pipeline/terraform.tfstate" # The path/folder structure inside your bucket
    region  = "eu-west-2"                            # Change this if your 'jenkins-terraform-s3-2026' bucket is in a different region
    encrypt = true                                   # Encrypts the state file at rest for security
  }
}
