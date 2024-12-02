# Create an S3 bucket
resource "aws_s3_bucket" "wordpress-project" {
  bucket = "wordpress-project"

  tags = {
    Name        = "wordpress s3"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.wordpress-project.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Create an IAM Role for EC2 instance
resource "aws_iam_role" "ec2_s3_role" {
  name               = "ec2_s3_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Effect    = "Allow"
        Sid       = ""
      }
    ]
  })
}