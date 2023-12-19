# variables.tf na raiz do seu projeto

variable "aws_region" {
  description = "Região AWS para todos os recursos"
  type        = string
  default     = "us-east-1"
}

variable "redshift_ingress_cidr_block" {
  description = "CIDR block for ingress to Redshift cluster"
  type        = string
}
