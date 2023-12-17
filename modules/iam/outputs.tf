# modules/iam/outputs.tf

output "s3_access_policy_arn" {
  description = "The ARN of the S3 access policy"
  value       = aws_iam_policy.s3_access.arn
}

output "job_glue_role_arn" {
  description = "The ARN of the job_glue IAM role"
  value       = aws_iam_role.job_glue_role.arn
}
