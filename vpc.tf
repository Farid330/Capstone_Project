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

resource "aws_subnet" "public-2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "eu-central-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-wordpress-2"
  }
}

#Private Subnets
resource "aws_subnet" "private-1" {
  vpc_id     = aws_vpc.main.id 
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "private-wordpress-1" 
  }
}