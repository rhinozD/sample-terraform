provider "aws" {
  region = local.region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.56.1"
    }
  }

  backend "s3" {
    bucket         = "sample-dev-tf-backend-bucket"
    key            = "state/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "sample-dev-tf-backend-table"
    encrypt        = true
  }
}
