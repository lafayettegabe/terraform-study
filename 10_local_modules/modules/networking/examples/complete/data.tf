locals {
  project = "project_name"
  region  = "us-east-1"
  common_tags = {
    Project   = local.project
    Terraform = "true"
  }
}
