# Data source to fetch the latest Amazon Linux 2 AMI (most_recent = true picks the newest).
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]  # Official AWS AMIs only.

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]  # Matches AL2 HVM GP2 (SSD) images.
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "server1" {
  instance_type          = "t3.micro"
  ami                    = data.aws_ami.amazon_linux_2.id  # Uses latest AL2 AMI dynamically.
  user_data              = file("setup.sh")  # Ensure setup.sh is in repo root.
  subnet_id              = aws_subnet.private1.id  # Assumes defined elsewhere.
  vpc_security_group_ids = [aws_security_group.web_sg.id]  # Assumes defined.
  tags = {
    Name = "webserver-1"
    Env  = "dev"
  }
}

resource "aws_instance" "server2" {
  instance_type          = "t3.micro"
  ami                    = data.aws_ami.amazon_linux_2.id  # Same latest AMI.
  user_data              = file("setup.sh")
  subnet_id              = aws_subnet.private2.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  tags = {
    Name = "webserver-2"
    Env  = "dev"
  }
}