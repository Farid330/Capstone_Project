#Launch Template
resource "aws_launch_template" "dev-launch-template" {
  name = "WebserverLaunchTemplate"
  //image_id = data.aws_ami.amzLinux.id
  image_id = "ami-05c9d06873bde2328"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.wordpress_sg.id]
  key_name = "deham9-iam"
  #user_data = file("userdatalaunchtemplate.sh")
  #user_data = "${base64encode(data.template_file.userdatatemplate.rendered)}" 

 }