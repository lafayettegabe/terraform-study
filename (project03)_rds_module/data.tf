locals {
  project = "project03_rds_module"
  region  = "us-east-1"
  common_tags = {
    Project   = local.project
    Terraform = "true"
  }
}
