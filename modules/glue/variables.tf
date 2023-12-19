variable "job_name" {
  description = "The name of the glue job"
  type        = string
}

variable "role_arn" {
  description = "The ARN of the IAM role that Glue will assume"
  type        = string
}

variable "s3_bucket_name" {
  description = "The S3 bucket where the Glue script is stored"
  type        = string
}

variable "script_path" {
  description = "The path to the Glue script within the S3 bucket"
  type        = string
}

variable "python_version" {
  description = "The version of Python to use"
  type        = string
  default     = "3"
}

variable "glue_version" {
  description = "The version of Glue to use"
  type        = string
  default     = "4.0"
}

variable "max_retries" {
  description = "The maximum number of times to retry this job if it fails"
  type        = number
  default     = 1
}

variable "default_arguments" {
  description = "A map of default arguments for this job"
  type        = map(string)
  default     = {}
}


