# Integration of Jenkins with GitHub and AWS
This repository automates infrastructure provisioning by integrating Jenkins with GitHub and AWS. 
Pushing code to your repository triggers a GitHub Webhook, which automatically executes a Jenkins Pipeline to create and manage your AWS S3 resources.

## Objectives & Architecture
This project demonstrates continuous integration and infrastructure as code by meeting the following objectives:
1. Writing a Terraform configuration to provision an AWS S3 bucket.
2. Managing infrastructure state and tracking resource details securely.
3. Automating the deployment of these configurations from a remote repository directly to AWS using a Jenkins pipeline.

## Repository Structure
This project consists of the following key configuration files:
- main.tf: Defines the core AWS resources to be created (S3 bucket).
- backend.tf: Configures remote or local state tracking for your Terraform resources.

## Implementation Guide
To set up and run this pipeline, follow these steps:
1. Prepare your Terraform Scripts:
   Write a configuration file designed to create an S3 bucket and upload it to a remote GitHub Repository.
2. Configure Webhooks:
   Set up a GitHub Service Hook to automatically notify your Jenkins Controller whenever a commit is pushed to your repository.
3. Build the Pipeline:
   Create a Jenkins pipeline job that pulls the latest code from your GitHub Repository on Push and applies your Terraform configurations to your AWS environment.
   Use this pipeline code or save this as a Jenkinsfile
```
pipeline {
    agent any

    // This block tells Jenkins to listen for the GitHub webhook trigger
    triggers {
        githubPush()
    }

    environment {
        // This securely injects your Jenkins credentials into AWS environment variables
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION    = 'eu-west-2' // Change this to your target AWS region
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Clones your Terraform code from your GitHub repository
                git branch: 'main', url: 'https://github.com/Benaro-integrity/terraform-s3-assignment.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                // The -auto-approve flag skips the manual "yes" confirmation prompt
                sh 'terraform apply -auto-approve'
            }
        }
    }
}

```


