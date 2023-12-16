# modules/s3_buckets/variables.tf

variable "bucket_name" {
  description = "bucket de teste"
  type        = string
}

variable "environment" {
  description = "Dev"
  type        = string
  default     = "Dev"
}

variable "autor" {
  description = "Autor do bucket"
  type        = string
  default     = "Vinícius Lucas"
}
