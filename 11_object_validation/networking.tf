data "aws_vpc" "default" {
  default = true
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "this" {
  count = 2

  vpc_id = data.aws_vpc.default.id
  # X.X.128.0/24 because the default VPC has a /16 CIDR block (16 + 8 = 24)
  cidr_block = cidrsubnet(data.aws_vpc.default.cidr_block, 8, 128 + count.index)
  availability_zone = data.aws_availability_zones.available.names[
    count.index % length(data.aws_availability_zones.available.names)
  ]

  lifecycle {
    create_before_destroy = true
    postcondition {
      condition     = contains(data.aws_availability_zones.available.names, self.availability_zone)
      error_message = "Invalid availability zone"
    }
  }
}

check "high_availability" {
  assert {
    condition     = can(length(aws_subnet.this[*].availability_zone) > 1)
    error_message = "High availability requires at least two different availability zones"
  }
}

# Check if the cidr_block is valid
output "vpc_cidr_block" {
  value = data.aws_vpc.default.cidr_block
}

output "cidr_block" {
  value = aws_subnet.this[*].cidr_block
}
