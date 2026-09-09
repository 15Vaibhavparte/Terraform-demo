# db for state lock 

resource "aws_dynamodb_table" "lock_table" {
  name         = "vaibhav-parte15-state_lock_table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  depends_on = [ aws_s3_bucket.bucket_name ]

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "vaibhav-parte15-state_lock_table"      
  }  

}



