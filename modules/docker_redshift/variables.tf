variable "aws_credentials_volume" {
  description = "Path to AWS credentials volume"
  type        = string
}

variable "redshift_endpoint" {
  description = "Endpoint of the Redshift cluster"
  type        = string
}

variable "redshift_cluster_identifier" {
  description = "Identifier for the Redshift cluster"
  type        = string
}

variable "database_name" {
  description = "Name of the Redshift database"
  type        = string
}

variable "master_username" {
  description = "Master username for the Redshift cluster"
  type        = string
}

variable "master_password" {
  description = "Master password for the Redshift cluster"
  type        = string
}

variable "aws_region" {
  description = "AWS region for the Redshift cluster"
  type        = string
}
