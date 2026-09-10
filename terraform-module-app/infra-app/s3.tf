
resource "aws_s3_bucket" "my_bucket" {
    bucket = "${var.env}-${var.bucket_name}"  # we will use the env variable to create a unique bucket name for each environment
    versioning {
        enabled = true
    }

    tags = {
        Name        = "${var.env}-${var.bucket_name}"
        Environment = var.env
    }
    }