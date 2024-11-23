terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-west-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0423fca164888b941"
  instance_type = "t2.micro"
  key_name = "iac-ec2"
  tags = {
    Name = "REDHAT_EC2_01"
  }
}