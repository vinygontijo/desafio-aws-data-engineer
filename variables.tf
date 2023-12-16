# variables.tf na raiz do seu projeto

variable "aws_region" {
  description = "Região AWS para todos os recursos"
  type        = string
  default     = "us-east-1"
}
