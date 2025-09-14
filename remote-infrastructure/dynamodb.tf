resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "terraform-state-bucket"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "lockID"

  attribute {
    name = "lockID"
    type = "S"
  }

  tags = {
    Name        = "terraform-dynamodb-lock-table"
  }
}