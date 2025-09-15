terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # storing state file to remote backend 
  backend "s3" {
    bucket = "terraform-state-bucket-6363"
    key = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-state-bucket"
    
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_security_group" "default_sg" {
  name        = "terraform_sg"
  description = "allow ssh and http traffic"
  vpc_id      = data.aws_vpc.default.id


  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform_sq_tag"
  }
}

resource "aws_key_pair" "my_key" {
  key_name   = "terraform-keypair"
  public_key = file("~/.ssh/id_ed25519.pub")
}

# resource "aws_instance" "my_instance" {
#   # count = 2
#   # for_each = tomap({
#   #   TWS-micro = "t3.micro"
#   #   TWS-small = "t3.small"
#   # })

#   depends_on = [ aws_security_group.default_sg ]
#   ami                         = "ami-0360c520857e3138f"
#   instance_type               = each.value
#   subnet_id                   = element(data.aws_subnets.default.ids, 0)
#   vpc_security_group_ids      = [aws_security_group.default_sg.id]
#   key_name                    = aws_key_pair.my_key.key_name
#   associate_public_ip_address = true
#   user_data                   = file("install_nginx.sh")

#   root_block_device {
#     volume_size = var.env == "dev" ? var.ec2_root_storage_size : 10
#   }




#   tags = {
#     Name = each.key
#   }
# }

resource "aws_instance" "my_instance" {
  depends_on = [ aws_security_group.default_sg ]
  ami                         = "ami-0360c520857e3138f"
  instance_type               = var.ec2_instance_type
  subnet_id                   = element(data.aws_subnets.default.ids, 0)
  vpc_security_group_ids      = [aws_security_group.default_sg.id]
  key_name                    = aws_key_pair.my_key.key_name
  associate_public_ip_address = true
  user_data                   = file("install_nginx.sh")

  root_block_device {
    volume_size = var.env == "default" ? var.ec2_root_storage_size : 10
    volume_type = "gp3"
  }

  tags = {
    Name = "TWS-server-default"
    Enviornment = var.env
  }
}
