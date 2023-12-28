variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the VPC"
  type        = list(string)
}
