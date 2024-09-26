# Networking Module

This module manages the creation of VPCs and Subnets, allowing for the creation of both private and public subnets.

Example usage:

```
locals {
  vpc_cidr = "10.0.0.0/16"
}

module "networking" {
  source = "./modules/networking"

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
      public     = true
      az         = "us-east-1b"
    }
  }
}
```
