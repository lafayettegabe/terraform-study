variable "subnet_count" {
  type = number
}

variable "ec2_instance_config_list" {
  type = list(object({
    instance_type = string
    ami           = string
  }))

  # Validate that only t3.micro and t3.small instance types are allowed
  validation {
    condition = alltrue([
      for config in var.ec2_instance_config_list : contains(["t3.micro", "t3.small"], config.instance_type)
    ])
    error_message = "Only 't3.micro' and 't3.small' instance types are allowed"
  }

  # Validate that only Ubuntu and Nginx AMIs are allowed
  validation {
    condition = alltrue([
      for config in var.ec2_instance_config_list : contains(["ubuntu", "nginx"], config.ami)
    ])
    error_message = "Only 'Ubuntu' and 'Nginx' AMIs are allowed"
  }
}

variable "ec2_instance_config_map" {
  type = map(object(
    {
      ami           = string
      instance_type = string
      subnet_index  = optional(number, 0)
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
