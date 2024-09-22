subnet_config = {
  "public_1" = {
    cidr_block = "10.0.0.0/24"
  },
  "private_1" = {
    cidr_block = "10.0.1.0/24"
  }
}

ec2_instance_config_map = {
  "ubuntu_1" = {
    ami           = "ubuntu",
    instance_type = "t3.small"
  },
  "nginx_1" = {
    ami           = "nginx",
    instance_type = "t3.micro"
    subnet        = "public_1"
  },
}
