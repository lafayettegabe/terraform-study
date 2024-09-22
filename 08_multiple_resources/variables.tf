variable "subnet_config" {
  type = map(object({
    cidr_block = string
  }))

  # Validate that the CIDR block is a valid IPv4 CIDR block
  validation {
    condition = alltrue([
      for config in values(var.subnet_config) : can(cidrsubnet(config.cidr_block, 8, 0))
    ])
    error_message = "CIDR block must be a valid IPv4 CIDR block"
  }
}

variable "ec2_instance_config_map" {
  type = map(object(
    {
      ami           = string
      instance_type = string
      subnet        = optional(string, "private_1")
    }
  ))

  # Validate that only t3.micro and t3.small instance types are allowed
  validation {
    condition = alltrue([
      for config in values(var.ec2_instance_config_map) : contains(["t3.micro", "t3.small"], config.instance_type)
    ])
    error_message = "Only 't3.micro' and 't3.small' instance types are allowed"
  }

  # Validate that only Ubuntu and Nginx AMIs are allowed
  validation {
    condition = alltrue([
      for config in values(var.ec2_instance_config_map) : contains(["ubuntu", "nginx"], config.ami)
    ])
    error_message = "Only 'Ubuntu' and 'Nginx' AMIs are allowed"
  }
}
