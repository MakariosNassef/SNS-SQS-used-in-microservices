resource "aws_s3_bucket" "maczbucket1" {
  bucket = "maczbucket1"
  tags = {
    Name        = "maczbucket1"
  }
}


resource "aws_s3_bucket" "maczbucket2" {
  bucket = "maczbucket2"
  tags = {
    Name        = "maczbucket2"
  }
}
