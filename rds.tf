#Creating DB Subnet Group
resource "aws_db_subnet_group" "aurora_subnet_group" {
  name       = "aurora-db-subnet-group"
  subnet_ids = [aws_subnet.private-1.id, aws_subnet.private-2.id]

  tags = {
    Name = "Aurora DB Subnet Group"
  }
}

#Adding security group for RDS Aurora
resource "aws_security_group" "rds_sg" {
  name        = "aurora-rds-sg"
  description = "Security group for Aurora RDS cluster"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks # e.g., CIDR blocks allowed to access the database
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDS Security Group"
  }
}