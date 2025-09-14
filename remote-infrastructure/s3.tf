resource "aws_s3_bucket" "remote-infra" {
  bucket = "terraform-state-bucket-6363" 

  tags = {
    Name = "Terraform State Manage Bucket"
  }
}