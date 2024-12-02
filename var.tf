#You can provide Date value if need to know when its created and what is happening
variable "tagNameDate" {
  default = ""
}


# VPC Variables
variable "cidr_blocks" {
  default = ["0.0.0.0/0"]
}

variable "availability_zones" {
  description = "List of availability zones"
  default     = ["eu-central-1a", "eu-central-1b"]
}

# EC2 Variables
variable "ec2_instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the EC2 key pair"
  default     = "WordPress Key"
}

# Variables for RDS DB instance

variable "rds_username" {
  description = "The username for the RDS instance"
}
variable "rds_password" {
  description = "The password for the RDS instance"
  sensitive   = true
}
variable "rds_db_name" {
  description = "The name of the database"
  default     = "wordpressDb"
}