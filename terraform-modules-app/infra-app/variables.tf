variable "env" {
    description = "The environment for the resources"
    type = string
}

variable "bucket_name" {
    description = "The name of the S3 bucket"
    type   = string
}

variable "ec2_instance_type" {
    description = "The type of EC2 instance to create"
    type        = string  
}

variable "ec2_root_storage_size" {
    description = "The size of the root storage for the EC2 instance in GB"
    type        = number  
}

variable "instance_count" {
    description = "Number of EC2 instances to create"
    type        = number
}

variable "ec2_ami_id" {
   description = "Ami id of you ec2 instance"
    type        = string
}

variable "hash_key" {
    description = "The hash key for the DynamoDB table"
    type        = string
  
}
