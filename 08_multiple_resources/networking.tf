resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name    = local.project
    Project = local.project
  }
}

resource "aws_subnet" "main" {
  count      = var.subnet_count
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.${count.index}.0/24"

  tags = {
    Name    = "${local.project}-subnet-${count.index}"
    Project = local.project
  }
}
