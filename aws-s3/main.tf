terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.2"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}


resource "aws_s3_bucket" "demo-bucket" {
  bucket = "Deepesh-Terraform-Practice-tf"
}

resource "aws_s3_object" "bucket-data" {
  bucket = aws_s3_bucket.demo-bucket.bucket
  source = "./localfile.txt"
  key    = "mydata.txt"
}

output "name" {
  value = aws_s3_bucket.demo-bucket.bucket
}