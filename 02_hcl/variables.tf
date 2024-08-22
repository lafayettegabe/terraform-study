variable "aws_region" {
  description = "The AWS region to deploy in"
  default     = "sa-east-1"
}

variable "aws_access_key_id" {
  description = "The AWS Terraform IAM user access key"
}

variable "aws_secret_access_key" {
  description = "The AWS Terraform IAM user secret key"
}

variable "bucket_name" {
  type        = string
  description = "My variable used to set bucket name"
  default     = "lafayettegabe-my-default-bucket-name"
}