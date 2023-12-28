# modules/iam/outputs.tf

output "s3_access_policy_arn" {
  description = "The ARN of the S3 access policy"
  value       = aws_iam_policy.s3_access.arn
}

output "job_glue_role_arn" {
  description = "The ARN of the job_glue IAM role"
  value       = aws_iam_role.job_glue_role.arn
}

output "redshift_access_policy_arn" {
  description = "The ARN of the Redshift access policy"
  value       = aws_iam_policy.redshift_access.arn
}

output "lambda_vpc_access_policy_arn" {
  value = aws_iam_policy.lambda_vpc_access.arn
}
