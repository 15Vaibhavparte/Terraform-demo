
resource "aws_s3_bucket" "bucket_name" {
    bucket = "vaibhav-parte-state-lock-demo"   
    force_destroy = true      #This cmd will empty the bucket if it has any content in it and then delete the bucket

    versioning {
        enabled = true
    }

}


 