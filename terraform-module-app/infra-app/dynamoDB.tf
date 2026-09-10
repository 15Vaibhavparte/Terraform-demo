# db for state lock 

resource "aws_dynamodb_table" "infra-dynamo-table" {
  name         = "${var.env}-infra-dynamo-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "var.hash_key"

  attribute {
    name = "var.hash_key"
    type = "S"
  }

  tags = {
    Name = "${var.env}-infra-dynamo-table"      
    Environment = var.env  
  }  

}



