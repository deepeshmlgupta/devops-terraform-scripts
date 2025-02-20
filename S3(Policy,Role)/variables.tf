variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "iam_user" {
  description = "The name of the IAM user"
  type        = string
}

variable "policy_name" {
  description = "The name of the IAM policy"
  type        = string
}
