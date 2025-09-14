variable "ec2_instance_type" {
  default = "t3.micro"
  type    = string
}

variable "env" {
  default = "dev"
}

variable "ec2_root_storage_size" {
  default = 8
  type    = number
}