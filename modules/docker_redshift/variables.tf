variable "redshift_endpoint" {
  description = "Endpoint for the Redshift cluster"
  type        = string
}

variable "redshift_cluster_identifier" {
  description = "Identifier for the Redshift cluster"
  type        = string
}

variable "database_name" {
  description = "Name of the database"
  type        = string
}

variable "master_username" {
  description = "Username for the Redshift cluster master user"
  type        = string
}

variable "master_password" {
  description = "Password for the Redshift cluster master user"
  type        = string
  sensitive   = true
}

variable "aws_region" {
  description = "AWS region where the Redshift cluster is deployed"
  type        = string
}

variable "aws_credentials_volume" {
  description = "Path to the volume where AWS credentials are stored"
  type        = string
  default     = "/home/viny/.aws"
}
