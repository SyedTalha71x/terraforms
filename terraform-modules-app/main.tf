module "dev-infra" {
    source = "./infra-app"
    env = "dev"
    bucket_name = "infra-app-bucket-v999999xx"
    instance_count = 1
    ec2_instance_type = "t3.micro"
    ec2_ami_id = "ami-0b09ffb6d8b58ca91"
    ec2_root_storage_size = 8
    hash_key = "id"
}   