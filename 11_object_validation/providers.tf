terraform {

  backend "s3" {
    bucket = "backend-terraform-0"
    key    = "11_object_validation/terraform.tfstate"
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
