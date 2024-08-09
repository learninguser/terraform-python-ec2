terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "learninguser"
    key            = "python-ec2"
    region         = "us-east-1"
    dynamodb_table = "terraform_lock"
  }
}

provider "aws" {
  region = "us-east-1"
}