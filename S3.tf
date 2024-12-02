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