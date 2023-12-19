output "redshift_cluster_endpoint" {
  description = "The endpoint of the Redshift cluster"
  value       = aws_redshift_cluster.redshift_cluster.endpoint
}
