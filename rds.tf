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

####### Aurora MySQL Configuration #######
resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier      = "aurora-cluster"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.11.1" # Specify a suitable version
  master_username         = var.db_username
  master_password         = var.db_password
  database_name           = var.db_name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.aurora_subnet_group.name
  skip_final_snapshot       = true
  final_snapshot_identifier = "aurora-final-snapshot"


  tags = {
    Name = "Aurora MySQL Cluster"
  }
}


resource "aws_rds_cluster_instance" "aurora_instances" {
  count             = 2
  identifier        = "aurora-instance-${count.index}"
  cluster_identifier = aws_rds_cluster.aurora_cluster.id
  instance_class    = "db.t3.small"
  engine            = aws_rds_cluster.aurora_cluster.engine
  engine_version    = aws_rds_cluster.aurora_cluster.engine_version
  publicly_accessible = false
  db_subnet_group_name = aws_db_subnet_group.aurora_subnet_group.name

  tags = {
    Name = "Aurora Instance ${count.index}"
  }
}