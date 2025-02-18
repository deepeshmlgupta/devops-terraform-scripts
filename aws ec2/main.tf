terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}

provider "aws" {
  region = var.region
}


resource "aws_instance" "myserver" {
  ami           = "ami-0ddfba243cbee3768"
  instance_type = "t2.micro"

  tags = {
    Name = "SampleServer"
  }
}