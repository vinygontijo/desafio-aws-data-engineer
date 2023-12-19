variable "vpc_id" {
  description = "The ID of the VPC where the endpoint will be created."
  type        = string
}

variable "service_name" {
  description = "The service name for the endpoint."
  type        = string
}
