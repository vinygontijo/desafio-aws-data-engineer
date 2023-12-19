variable "vpc_id" {
  description = "VPC ID to create subnets in"
  type        = string
}

variable "subnets" {
  description = "A map of subnets to create"
  type = map(object({
    cidr_block        = string
    availability_zone = string
    name              = string
  }))
}
