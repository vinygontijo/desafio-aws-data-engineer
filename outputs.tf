# outputs.tf

output "s3_access_policy_arn" {
  value       = module.iam.s3_access_policy_arn
  description = "The ARN of the S3 access policy"
}

output "redshift_cluster_endpoint" {
  description = "The endpoint of the Redshift cluster"
  value       = module.redshift.redshift_cluster_endpoint
}

output "s3_vpc_endpoint_id" {
  description = "The ID of the S3 VPC endpoint."
  value       = module.s3_vpc_endpoint.s3_endpoint_id
}

output "s3_vpc_endpoint_dns_entry" {
  description = "The DNS entries for the S3 VPC endpoint."
  value       = module.s3_vpc_endpoint.s3_endpoint_dns_entry
}
