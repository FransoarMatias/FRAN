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
  region  = "sa-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0f16d0d3ac759edfa"
  instance_type = "t2.micro"
  key_name = "iac-ansible"
  tags = {
    Name = "SRV_DELTA_01"
  }
}