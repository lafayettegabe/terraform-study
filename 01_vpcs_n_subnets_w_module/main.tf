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

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my_vpc"
  cidr = "10.0.0.0/16"

  azs             = ["sa-east-1a"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.0.0/24"]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}