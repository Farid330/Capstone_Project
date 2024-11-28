# Security Group for ALB
resource "aws_security_group" "lb_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "wordpress-lb-sg"
  }
}

# Application Load Balancer (ALB)
resource "aws_lb" "wordpress_lb" {
  name               = "wordpress-alb"
  internal           = false  
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.public-1.id, aws_subnet.public-2.id]
  enable_deletion_protection = false
  idle_timeout       = 60

  tags = {
    Name = "wordpress-alb"
  }
}

resource "aws_lb_target_group" "Wordpress_target_group" {
  name        = "wordpress-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "instance"

  # Add tags
  tags = {
    Name = "wordpress-target-group ${var.tagNameDate}"
  }
}