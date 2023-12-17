variable "glue_service_role_arn" {
  description = "The ARN of the IAM role used by the Glue Crawler"
  type        = string
}

variable "s3_target_path" {
  description = "The S3 path that the crawler will target"
  type        = string
  default     = "s3://letrus-educacao-pdde-teste/raw/"
}

variable "database_name" {
  description = "The name of the Glue database where the table will be created"
  type        = string
}
