resource "aws_instance" "nginx" {
  ami           = "ami-046da274b67868bfd" # NGINX AMI
  instance_type = "t2.micro"

  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.public_http_traffic.id]

  root_block_device {
    volume_size           = 10
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "proj00-ec2-nginx"
  }
}

resource "aws_security_group" "public_http_traffic" {
  vpc_id = aws_vpc.main.id

  name        = "public-http-traffic"
  description = "Security group allowing traffic on ports 443 and 80"

  tags = {
    Name = "proj00-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"

  tags = {
    Name = "proj00-sgr-http"
  }
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"

  tags = {
    Name = "proj00-sgr-https"
  }
}
