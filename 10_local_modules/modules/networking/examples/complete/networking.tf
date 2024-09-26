locals {
  vpc_cidr = "10.0.0.0/16"
}

module "networking" {
  source = "../.."

  vpc_config = {
    name       = local.project
    cidr_block = local.vpc_cidr
  }

  subnet_config = {
    subnet_1 = {
      cidr_block = "10.0.0.0/24"
      az         = "us-east-1a"
    },
    subnet_2 = {
      cidr_block = "10.0.1.0/24"
      # Public subnets are indicated by setting the `public` attribute to `true`
      public = true
      az     = "us-east-1b"
    }
  }
}
