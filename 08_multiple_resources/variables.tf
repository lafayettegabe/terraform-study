variable "subnet_count" {
  type = number
}

variable "ec2_instance_count" {
  type = number
}

variable "ec2_instance_config" {
  type = list(object({
    instance_type = string
    ami           = string
  }))
}
