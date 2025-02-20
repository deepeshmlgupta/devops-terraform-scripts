terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# Create S3 Bucket
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
}

# Create IAM User
resource "aws_iam_user" "iam_user" {
  name = var.iam_user
}

# Create IAM Access Key for the User
resource "aws_iam_access_key" "access_keys" {
  user = aws_iam_user.iam_user.name
}

# Define the IAM Policy for S3 Bucket
resource "aws_iam_policy" "s3_bucket_policy" {
  name        = "${var.policy_name}"
  description = "Policy for full admin access to the S3 bucket ${var.bucket_name}"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:ListBucket", "s3:GetBucketLocation"]
        Resource = "arn:aws:s3:::${var.bucket_name}"
      },
      {
        Effect   = "Allow"
        Action   = ["s3:PutObject", "s3:GetObject", "s3:ListBucketMultipartUploads", "s3:ListMultipartUploadParts", "s3:AbortMultipartUpload"]
        Resource = "arn:aws:s3:::${var.bucket_name}/*"
      },
      {
        Effect   = "Allow"
        Action   = "s3:*"
        Resource = [
          "arn:aws:s3:::${var.bucket_name}",
          "arn:aws:s3:::${var.bucket_name}/*"
        ]
      }
    ]
  })
}

# Attach the Policy to the IAM User
resource "aws_iam_user_policy_attachment" "attach_s3_policy" {
  user       = aws_iam_user.iam_user.name
  policy_arn = aws_iam_policy.s3_bucket_policy.arn
}


resource "null_resource" "append_aws_keys" {
  provisioner "local-exec" {
    command = <<EOT
      echo "---------------------------------------------------------------------" >> aws_cred.txt
      echo "🪣S3_BUCKET_NAME: ${aws_s3_bucket.s3_bucket.bucket}" >> aws_cred.txt
      echo "👤IAM_USER_NAME: ${aws_iam_user.iam_user.name}" >> aws_cred.txt
      echo "📜IAM_POLICY_NAME: ${aws_iam_policy.s3_bucket_policy.name}" >> aws_cred.txt
      echo "✅AWS_ACCESS_KEY_ID: ${aws_iam_access_key.access_keys.id}" >> aws_cred.txt
      echo "🔑AWS_SECRET_ACCESS_KEY: ${aws_iam_access_key.access_keys.secret}" >> aws_cred.txt
      echo "-------------------------------❌-❌-❌------------------------------" >> aws_cred.txt
    EOT
  }
}


# Outputs (Optional)
output "s3_bucket_name" {
  value = aws_s3_bucket.s3_bucket.bucket
}

output "aws_access_key" {
  value = aws_iam_access_key.access_keys.id
}

output "aws_secret_access_key" {
  value = aws_iam_access_key.access_keys.secret
  sensitive = true
}
