#Launch Template
resource "aws_launch_template" "wordpress" {
  name = "WordPressLaunchTmpl"
  //image_id = data.aws_ami.amzLinux.id
  image_id =data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.wordpress_sg.id]
  key_name = var.key_name
  #user_data = file("userdatalaunchtemplate.sh")
  #user_data = "${base64encode(data.template_file.userdatatemplate.rendered)}" 

 }

 #Autoscaling Group
resource "aws_autoscaling_group" "WordPress-AutoScalingGroup" {
  name                              = "WordPress-EC2-Autoscaling-group"
  max_size                          = 4
  min_size                          = 1
  desired_capacity                  = 2
  
  vpc_zone_identifier               = [aws_subnet.public-1.id,aws_subnet.public-2.id]
  target_group_arns                 = [aws_lb_target_group.Wordpress_target_group.arn]
  health_check_type                 = "ELB"
  health_check_grace_period         = 300

  launch_template {
    id                              = aws_launch_template.wordpress.id
    version                         = "$Latest"
  }
}


#Autoscaling policy

resource "aws_autoscaling_policy" "wordpress_policy" {
  name                              = "CPUpolicy"
  policy_type                       = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type        = "ASGAverageCPUUtilization"
    }
      target_value                  = 70.0
  }
  autoscaling_group_name            = aws_autoscaling_group.WordPress-AutoScalingGroup.name
}