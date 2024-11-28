#! /bin/bash
# # Install updates
sudo yum update -y

# Configure AWS CLI with IAM role credentials
aws configure set default.region eu-central-1

sudo yum install -y stress-ng

#Install httpd
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd

#Install mysql
sudo yum install -y mysql

#Install PHP
sudo yum install -y php 
sudo amazon-linux-extras install 


# Update all installed 
sudo yum update -y

#Restart Apache
sudo systemctl restart httpd