# modules/s3_buckets/variables.tf

variable "bucket_name" {
  description = "Nome do bucket de teste"
  type        = string
}

variable "environment" {
  description = "Ambiente de implantação do bucket"
  type        = string
  default     = "Dev"
}

variable "autor" {
  description = "Autor do bucket"
  type        = string
  default     = "Vinícius Lucas"
}

