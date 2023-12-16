variable "s3_bucket_name" {
  description = "The S3 bucket associated with the IAM policy"
  type        = string
}

variable "iam_role_name" {
  description = "The name of the IAM role to attach the policy to"
  type        = string
}

variable "aws_account_id" {
  description = "The AWS account ID"
  type        = string
}

variable "destination_s3_bucket_name" {
  description = "The S3 bucket for Glue job destination"
  type        = string
}
