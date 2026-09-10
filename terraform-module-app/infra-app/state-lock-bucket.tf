

resource "aws_s3_bucket" "state_lock_bucket" {
    bucket = "state-lock-bucket-vaibhav15"  

    versioning {
        enabled = true
    }
  
}