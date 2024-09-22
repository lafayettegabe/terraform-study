subnet_count = 2

ec2_instance_config_list = [
  {
    ami           = "ubuntu",
    instance_type = "t3.small"
  },
  {
    ami           = "nginx",
    instance_type = "t3.micro"
  }
]

ec2_instance_config_map = {
  "ubuntu_1" = {
    ami           = "ubuntu",
    instance_type = "t3.small"
  },
  "nginx_1" = {
    ami           = "nginx",
    instance_type = "t3.micro"
    subnet_index  = 1
  },
}
