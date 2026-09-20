resource "aws_s3_bucket" "terraform_state" {
  bucket = "vaibhav-parte-state-lock-demo" # Must be globally unique

    tags = {
        Name        = "terraform-state"
    }
}

# Standard 1: Versioning for disaster recovery
resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}