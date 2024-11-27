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

resource "aws_subnet" "private-2" {
  vpc_id     = aws_vpc.main.id 
  cidr_block = "10.0.4.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    Name = "private-wordpress-2" 
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "IGW for Wordpress"
  }
}

#Public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public-route-table"
  }
}

#Associate Public Subnets with the Public Route Table
resource "aws_route_table_association" "public_1_assoc" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_route_table.id
  depends_on     = [aws_route_table.RB_Public_RouteTable, aws_subnet.public-1]
}

resource "aws_route_table_association" "public_2_assoc" {
  subnet_id      = aws_subnet.public-2.id
  route_table_id = aws_route_table.public_route_table.id
  depends_on     = [aws_route_table.RB_Public_RouteTable, aws_subnet.public-2]
}