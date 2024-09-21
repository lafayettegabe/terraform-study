subnet_count = 2

ec2_instance_config = [
  {
    ami           = "ubuntu",
    instance_type = "t3.small"
  },
  {
    ami           = "nginx",
    instance_type = "t3.micro"
  }
]
