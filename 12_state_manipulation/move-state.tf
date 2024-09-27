/*
1. terraform state mv ARGS...
*/

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

# old name was "instance"
# terraform state mv aws_instance.instance aws_instance.new
# changed to count = 2 and moved the aws_instance.new to aws_instance.new_list[0]
resource "aws_instance" "new_list" {
  count = 2

  ami           = data.aws_ami.ubuntu.id 
  instance_type = "t2.micro"
}

/*
2. use moved block to update the configuration

moved {
  from = aws_instance.instance
  to   = aws_instance.new
}

moved {
  from = aws_instance.new
  to   = aws_instance.new_list[0]
}
*/
