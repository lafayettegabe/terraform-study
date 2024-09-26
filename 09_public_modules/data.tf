locals {
  project = "09_public_modules"
  region  = "us-east-1"
  common_tags = {
    Project   = local.project
    Terraform = "true"
  }
}
