provider "aws" {
  region = "us-east-1"
  access_key = "AKIAUPDG5DXVLQFHZXOD"
  secret_key = "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"
}
resource "aws_instance" "instance" {
  ami="ami-0715c1897453cabd1"
  instance_type = "t2.micro"
  key_name = "virginia-keypair"
#   count = 2
  tags = {
    Name="instance-vpc"
  }
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "CIDR block for the subnet"
  default     = "10.0.0.0/24"
}
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "MyVPC"
  }
}
resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.subnet_cidr_block
  availability_zone = "us-east-1a"
  tags = {
    Name = "MySubnet"
  }
}
# vpc_cidr_block = "10.0.0.0/16"
# subnet_cidr_block = "10.0.0.0/24"

resource "aws_security_group" "sec_grp" {
  name = "security_grp"
  description = "Allow HTTP and SSH traffic via Terraform"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

