# Captone_Project

# Project Objective:

The objective of this project is to deploy a fault-tolerant WordPress website using AWS services, with a MySQL database for content management. The solution will leverage Auto Scaling and an Application Load Balancer (ALB) to ensure high availability across two Availability Zones. CloudWatch will be utilized for monitoring and logging, ensuring optimized performance and reliability.



# Installation Instructions
   Step-by-step Guide:

1. Prerequisites
    Install Terraform. (hyperlink)
    AWS CLI configured with appropriate IAM permissions.

2. Setup Steps:
    Creat User data for EC2 instances in order to install necessary services for hosting a Wordpress server.
    Launch EC2 instance in public subnet 1 with WordPress AMI installed.
    Define an Auto Scaling Group with policies to maintain availability.
    Create an RDS MySQL instance for WordPress data.
    Create an ALB with target groups pointing to EC2 instances.
    Monitor Using CloudWatch

# Features

1. High Availability:
    Application Load Balancer ensures traffic distribution across instances in two Availability Zones.
2. Fault Tolerance:
    Auto Scaling maintains instance health and replaces failed nodes automatically.
3. Database Integration:
    WordPress seamlessly connects with MySQL for efficient content management.
4. Monitoring:
    CloudWatch provides real-time insights, logs, and alarms for system performance.
5. Scalability:
    Automatically adjusts to traffic spikes, ensuring an uninterrupted user experience.
