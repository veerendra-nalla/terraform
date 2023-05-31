provider "aws" {
  region="us-east-1"
  access_key = "AKIAUPDG5DXVLQFHZXOD"
  secret_key = "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"
}
resource "aws_instance" "multi-instances" {
  ami="ami-0715c1897453cabd1"
  instance_type = "t2.micro"
  key_name = "virginia-keypair"
  count = 2
  tags = {
    Name="multiple2"
  }
}
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
