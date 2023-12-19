variable "vpc_id" {
  description = "The VPC ID to create the security group in"
  type        = string
}

variable "ingress_cidr_block" {
  description = "CIDR block for the ingress rule"
  type        = string
}
