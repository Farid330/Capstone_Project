#Creating DB Subnet Group
resource "aws_db_subnet_group" "aurora_subnet_group" {
  name       = "aurora-db-subnet-group"
  subnet_ids = [aws_subnet.private-1.id, aws_subnet.private-2.id]

  tags = {
    Name = "Aurora DB Subnet Group"
  }
}