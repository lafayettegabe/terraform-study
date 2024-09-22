resource "aws_instance" "from_count" {
  count = length(var.ec2_instance_config_list)

  ami           = local.ami_ids[var.ec2_instance_config_list[count.index].ami]
  instance_type = var.ec2_instance_config_list[count.index].instance_type
  subnet_id     = aws_subnet.main[count.index % var.subnet_count].id

  tags = {
    Project = local.project
    Name    = "${local.project}-instance-${count.index}"
    AMI     = var.ec2_instance_config_list[count.index].ami
  }
}

# each.key is the key of the map, and each.value is the value of the map
resource "aws_instance" "from_map" {
  for_each = var.ec2_instance_config_map

  ami           = local.ami_ids[each.value.ami]
  instance_type = each.value.instance_type
  subnet_id     = aws_subnet.main[each.value.subnet_index % var.subnet_count].id

  tags = {
    Project = local.project
    Name    = "${local.project}-instance-${each.key}"
    AMI     = each.value.ami
  }
}
