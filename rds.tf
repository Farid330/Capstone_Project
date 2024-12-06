#Creating DB Subnet Group
resource "aws_db_subnet_group" "private_group" {
  name       = "mysql-db-subnet-group"
  subnet_ids = [aws_subnet.private-1.id, aws_subnet.private-2.id]

  tags = {
    Name = "Private-group"
  }
}

#Adding security group for RDS MYSQL
resource "aws_security_group" "rds_sg" {
  name        = "mysql-sg"
  description = "Security group for mysql db"
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

# Create RDS Database
resource "aws_db_instance" "mysql" {
  allocated_storage      = "10"
  db_name                = var.db_name
  engine                 = "mysql"
  engine_version         = "8.0.35"
  instance_class         = "db.t3.micro"
  identifier             = "rds-db"
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  multi_az               = false
  storage_encrypted      = false
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.private_group.name
    tags = {
    Name = "rds_db ${var.tagNameDate}"
  }
}

data "aws_db_instance" "mysql_data" {
  db_instance_identifier = aws_db_instance.mysql.identifier
}

#Get Database name, username, password, endpoint from above RDS
output "rds_db_name" {
  value = aws_db_instance.mysql_data.db_name
}
output "rds_username" {
  value = var.db_username
}
output "rds_passwordword" {
  value     = var.db_password
  sensitive = true
}
output "rds_endpoint" {
  value = aws_db_instance.mysql_data.endpoint
}