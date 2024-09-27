terraform {

  backend "s3" {
    bucket = "backend-terraform-0"
    key    = "12_state_manipulation/terraform.tfstate"
    region = "sa-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = local.region
}
