#Security group for EC2 Wordpress
resource "aws_security_group" "wordpress_sg" {
  name        = "wordpress_sg"
  description = "Security group for WordPress instance"

  vpc_id = aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }

  egress {
    description = "All traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr_blocks
  }

  tags = {
    Name = "wordpress_sg ${var.tagNameDate}"
  }
}

#######EC2 WordPress configuration#######
locals {
  name = "WordPress Instance ${var.tagNameDate}"
}
#Get latest ami ID of Amazon Linux 2
data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20241113.1-x86_64-gp2"]
  }
}

###Create EC2 instance WordPress
resource "aws_instance" "wordpress_instance" {
  ami                         = data.aws_ami.amazon_linux2.id
  instance_type               = var.ec2_instance_type
  availability_zone           = var.availability_zones[0]
  key_name                    = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.wordpress_sg.id]
  subnet_id                   = aws_subnet.public-1.id 



  tags = {
    Name = local.name
  }
}