locals {
  allowed_instance_types = [
    "t2.micro",
    "t3.micro",
  ]
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.this[0].id

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }

  /*
  tags = {
    CostCenter = "12345"
  }
  */

  lifecycle {
    create_before_destroy = true
    # Execute before creating the resource: pre
    # Don't catch hardcoded values for instance_type
    precondition {
      condition     = contains(local.allowed_instance_types, var.instance_type)
      error_message = "Invalid instance type"
    }

    # Execute after creating the resource: post
    # Catch hardcoded values for instance_type
    postcondition {
      condition     = contains(local.allowed_instance_types, self.instance_type)
      error_message = "Invalid instance type"
    }
  }
}

check "cost_center_check" {
  assert {
    condition     = can(aws_instance.this.tags.CostCenter != "")
    error_message = "CostCenter tag is required"
  }
}
