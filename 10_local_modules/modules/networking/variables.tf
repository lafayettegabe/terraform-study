variable "vpc_config" {
  description = "The configuration for the VPC"
  type = object({
    cidr_block = string
    name       = string
  })

  validation {
    condition     = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "The vpc_config.cidr_block must contain a valid CIDR block."
  }

  validation {
    condition     = length(var.vpc_config.name) <= 255
    error_message = "The vpc_config.name must be less than or equal to 255 characters."
  }
}

variable "subnet_config" {
  type = map(object({
    cidr_block = string
    public     = optional(bool, false)
    az         = string
  }))

  validation {
    condition = alltrue([
      for config in values(var.subnet_config) : can(cidrnetmask(config.cidr_block))
    ])
    error_message = "The subnet_config.cidr_block must contain a valid CIDR block."
  }
}
