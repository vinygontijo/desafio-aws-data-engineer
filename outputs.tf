# outputs.tf

output "meu_bucket_name" {
  value = module.s3_bucket.meu_bucket_name
}

output "meu_bucket_arn" {
  value = module.s3_bucket.meu_bucket_arn
}

output "s3_access_policy_arn" {
  value       = module.iam.s3_access_policy_arn
  description = "The ARN of the S3 access policy"
}