# Create an S3 bucket
resource "aws_s3_bucket" "wordpress-project" {
  bucket = "wordpress-project"

  tags = {
    Name        = "wordpress s3"
    Environment = "Dev"
  }
}
