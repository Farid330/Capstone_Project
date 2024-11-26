# VPC Configuration
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16" 
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "wordpress-vpc"
  }
}

# Public Subnets
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24" 
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-wordpress-1"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw ${var.tagNameDate}"
  }
