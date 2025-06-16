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
  ami           = "ami-0fe9bb1a9264e4983" ## RedHat 9
  instance_type = "t2.micro"
  key_name = "iac-ansible"
  tags = {
    Name = "SRV_DELTA_01"
  }
}