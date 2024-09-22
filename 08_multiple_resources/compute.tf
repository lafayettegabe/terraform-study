resource "aws_instance" "from_map" {
  for_each = var.ec2_instance_config_map

  ami           = local.ami_ids[each.value.ami]
  instance_type = each.value.instance_type
  subnet_id     = aws_subnet.main[each.value.subnet].id

  tags = {
    Project = local.project
    Name    = "${local.project}-instance-${each.key}"
    AMI     = each.value.ami
  }
}
