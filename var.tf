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
  default     = ["us-west-1a", "us-west-1b"]
}

# EC2 Variables
variable "ec2_instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the EC2 key pair"
  default     = "vockey"
}

###Variables for RDS

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "Ghost330" # Replace with your desired username
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true    # Ensures password isn't exposed in Terraform outputs
  default     = "ghost15823" # Replace with your desired password
}

 variable "db_name" {
  description = "Database name"
  type        = string
  default     = "wordpressdb"
}