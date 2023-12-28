variable "vpc_id" {
  description = "The VPC ID to create the security group in"
  type        = string
}

variable "ingress_cidr_block" {
  description = "CIDR block for the ingress rule"
  type        = string
}


variable "lambda_security_group_id" {
  description = "ID do grupo de segurança associado à função Lambda"
  type        = string
}


variable "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  type        = string
}

variable "redshift_security_group_id" {
  description = "Security group ID for the Redshift cluster"
  type        = string
}


variable "redshift_cidr_block" {
  description = "CIDR block for the Redshift security group"
  type        = string
}
