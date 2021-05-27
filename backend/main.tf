resource "aws_s3_bucket" "tf-state" {
  bucket = var.BUCKET_NAME
  acl    = "private"

  versioning {
    enabled = true
  }
}
