# outputs.tf

output "s3_access_policy_arn" {
  value       = module.iam.s3_access_policy_arn
  description = "The ARN of the S3 access policy"
}