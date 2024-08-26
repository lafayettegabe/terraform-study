terraform {

  backend "s3" {
    bucket = "backend-terraform-0"
    key    = "06_ds_fetching_ami_data/state.tfstate"
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
  region = var.aws_region
}
