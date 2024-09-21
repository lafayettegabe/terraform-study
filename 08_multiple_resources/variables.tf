variable "subnet_count" {
  type = number
}

variable "ec2_instance_config" {
  type = list(object({
    instance_type = string
    ami           = string
  }))

  # Validate that only t3.micro and t3.small instance types are allowed
  validation {
    condition = alltrue([
      for config in var.ec2_instance_config : contains(["t3.micro", "t3.small"], config.instance_type)
    ])
    error_message = "Only 't3.micro' and 't3.small' instance types are allowed"
  }

  # Validate that only Ubuntu and Nginx AMIs are allowed
  validation {
    condition = alltrue([
      for config in var.ec2_instance_config : contains(["ubuntu", "nginx"], config.ami)
    ])
    error_message = "Only 'Ubuntu' and 'Nginx' AMIs are allowed"
  }
}
