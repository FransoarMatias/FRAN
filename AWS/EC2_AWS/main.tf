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
  ami           = "ami-04dd23e62ed049936"
  instance_type = "t2.micro"
  key_name = "iac-ec2"
  #user_data = <<-EOF
  #            #!/bin/bash
  #            cd /home/ubuntu
  #            echo "<h1>Feito com Terraform</h1>" > index.html
  #            nohup busybox httpd -f -p 8080 &
  #            EOF
  tags = {
    Name = "SRV_UBUNTU_01"
  }
}