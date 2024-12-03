# Create an S3 bucket
resource "aws_s3_bucket" "wordpress-project" {
  bucket = "wordpress-project"


  tags = {
    Name        = "wordpress s3"
    Environment = "Dev"
  }

}  
#Gets objectlockconfiguration error due to lab IAM restrictions

###Create an IAM Role for EC2 instance
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

 #Attach the S3 full access policy to the IAM role
resource "aws_iam_role_policy" "ec2_s3_policy" {
  name   = "ec2_s3_policy"
  role   = aws_iam_role.ec2_s3_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.wordpress-project.bucket}",
          "arn:aws:s3:::${aws_s3_bucket.wordpress-project.bucket}/*"
        ]
      }
    ]
  })
}