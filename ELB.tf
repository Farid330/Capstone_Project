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
