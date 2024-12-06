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

#Set Database Variables 
DBName="wordpressdb"
DBUser="Ghost330"
DBPassword="ghost15823"
DBHost=$(echo "${rds_endpoint}" | sed 's/:3306//')


# Create a temporary file to store the database value
sudo touch db.txt
sudo chmod 777 db.txt
sudo echo "DATABASE $DBName;" >> db.txt
sudo echo "USER $DBUser;" >> db.txt
sudo echo "PASSWORD $DBPassword;" >> db.txt
sudo echo "HOST $RDS_ENDPOINT;" >> db.txt

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

sudo sed -i "s/'database_name_here'/'$DBName'/g" /var/www/html/wp-config.php
sudo sed -i "s/'username_here'/'$DBUser'/g" /var/www/html/wp-config.php
sudo sed -i "s/'password_here'/'$DBPassword'/g" /var/www/html/wp-config.php
sudo sed -i "s/'localhost'/'$DBHost'/g" /var/www/html/wp-config.php

#Grant permissions
sudo usermod -a -G apache ec2-user 
sudo chown -R ec2-user:apache /var/www 
sudo chmod 2775 /var/www 
find /var/www -type d -exec chmod 2775 {} \; 
find /var/www -type f -exec chmod 0664 {} \;


# Restart Apache
sudo systemctl restart httpd