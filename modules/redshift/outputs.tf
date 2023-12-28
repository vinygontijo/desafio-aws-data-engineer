output "redshift_cluster_endpoint" {
  description = "The endpoint of the Redshift cluster"
  value       = aws_redshift_cluster.redshift_cluster.endpoint
}

output "database_name" {
  description = "The name of the database to create when the cluster is created"
  value       = var.database_name
}

output "master_username" {
  description = "Username for the master DB user"
  value       = var.master_username
}

output "master_password" {
  value = var.master_password
  sensitive = true
}


output "security_group_id" {
  value = element(tolist(aws_redshift_cluster.redshift_cluster.vpc_security_group_ids), 0)
}

# modules/redshift/outputs.tf

output "cluster_identifier" {
  value = aws_redshift_cluster.redshift_cluster.cluster_identifier
}

