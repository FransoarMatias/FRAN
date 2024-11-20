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
  ami           = "ami-05b40ce1c0e236ef2"
  instance_type = "t2.micro"

  tags = {
    Name = "EC2_AWS_1"
  }
}