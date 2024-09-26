locals {
  project = "10_local_modules"
  region  = "us-east-1"
  common_tags = {
    Project   = local.project
    Terraform = "true"
  }
}
