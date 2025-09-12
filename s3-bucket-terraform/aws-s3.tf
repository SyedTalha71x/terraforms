provider "aws" {
    region = "us-east-1"
}

resource "aws_s3_bucket" "my-bucket" {
    bucket = "talha-terraform-demo-bucket"
    acl = "private"

    tags = {
       name = "MyDemoBucket"
       Environment = "Dev"
    }
}