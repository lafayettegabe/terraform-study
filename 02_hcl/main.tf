terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}

data "aws_s3_bucket" "my_external_bucket" {
  bucket = "not-managed-by-us"
}

module "my_module" {
  source = "./module-example"
}