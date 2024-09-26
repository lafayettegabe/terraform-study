locals {
  project = "09_public_modules"
  region  = "us-east-1"
}

data "aws_availability_zones" "azs" {
  state = "available"
}
