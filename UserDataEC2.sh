#! /bin/bash
# # Install updates
sudo yum update -y

# Configure AWS CLI with IAM role credentials
aws configure set default.region eu-central-1

#Install httpd
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd

#Install PHP & mysql
sudo amazon-linux-extras install -y php8.0
sudo amazon-linux-extras enable mariadb10.5
sudo yum clean metadata
sudo yum install -y mariadb unzip

sudo yum install mysql -y
sudo yum install php-mysql -y

#Restart Apache
sudo systemctl restart httpd

# Download and install Wordpress
sudo yum install -y wget
sudo wget http://wordpress.org/latest.tar.gz -P /var/www/html/
cd /var/www/html
sudo tar -zxvf latest.tar.gz 
sudo cp -rvf wordpress/* . 
sudo rm -rf wordpress  
sudo rm -f latest.tar.gz

# #Start MariaDB service and enable it on system startup
# sudo systemctl start mariadb
# sudo systemctl enable mariadb

# #Set Mariadb root password
# DBRootPassword='rootpassword'
# mysqladmin -u root password $DBRootPassword

# # # Set database variables
# DBName='wordpressdb'
# DBUser='Ghost330'
# DBPassword='ghost15823'

# Update all installed 
sudo yum update -y

#Restart Apache
sudo systemctl restart httpd

# # Configure Wordpress

sudo cp ./wp-config-sample.php ./wp-config.php # rename the file from sample to clean
sudo sed -i "s/'database_name_here'/'$DBName'/g" wp-config.php
sudo sed -i "s/'username_here'/'$DBUser'/g" wp-config.php
sudo sed -i "s/'password_here'/'$DBPassword'/g" wp-config.php
sudo sed -i "s/'localhost'/'$RDS_ENDPOINT'/g" wp-config.php

#Grant permissions
usermod -a -G apache ec2-user 
chown -R ec2-user:apache /var/www 
chmod 2775 /var/www 
find /var/www -type d -exec chmod 2775 {} \; 
find /var/www -type f -exec chmod 0664 {} \;


# Restart Apache
sudo systemctl restart httpd