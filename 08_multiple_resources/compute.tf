resource "aws_instance" "from_count" {
  count         = length(var.ec2_instance_config)
  ami           = local.ami_ids[var.ec2_instance_config[count.index].ami]
  instance_type = var.ec2_instance_config[count.index].instance_type
  subnet_id     = aws_subnet.main[count.index % var.subnet_count].id

  tags = {
    Project = local.project
    Name    = "${local.project}-instance-${count.index}"
    AMI     = var.ec2_instance_config[count.index].ami
  }
}
