locals {
  project = "12_state_manipulation"
  region  = "us-east-1"
  common_tags = {
    Project   = local.project
    Terraform = "true"
  }
}
