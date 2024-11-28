#Launch Template
resource "aws_launch_template" "dev-launch-template" {
  name = "WordPress_Ec2_LaunchTemplate"
  image_id = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.wordpress_sg.id]
  key_name = var.key_name
  #user_data = file("userdatalaunchtemplate.sh")
  #user_data = "${base64encode(data.template_file.userdatatemplate.rendered)}" 

 }