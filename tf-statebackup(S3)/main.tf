terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
  backend "s3" {
    bucket = "Deepesh-Terraform-Practice-tf"
    key    = "backup.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = ap-south-1
}


resource "aws_instance" "myserver" {
  ami           = "ami-0ddfba243cbee3768"
  instance_type = "t2.micro"

  tags = {
    Name = "SampleServer"
  }
}