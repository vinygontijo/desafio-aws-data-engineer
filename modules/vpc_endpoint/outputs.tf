output "s3_endpoint_id" {
  description = "The ID of the S3 VPC endpoint."
  value       = aws_vpc_endpoint.s3_endpoint.id
}

output "s3_endpoint_dns_entry" {
  description = "The DNS entries for the S3 VPC endpoint."
  value       = aws_vpc_endpoint.s3_endpoint.dns_entry
}
