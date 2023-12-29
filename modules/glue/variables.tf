variable "job_name_1" {
  description = "The name of the first glue job"
  type        = string
}

variable "job_name_2" {
  description = "The name of the second glue job"
  type        = string
}

variable "role_arn" {
  description = "The ARN of the IAM role that Glue will assume"
  type        = string
}

variable "s3_bucket_name" {
  description = "The S3 bucket where the Glue scripts are stored"
  type        = string
}

variable "script_path_1" {
  description = "The path to the first Glue script within the S3 bucket"
  type        = string
}

variable "script_path_2" {
  description = "The path to the second Glue script within the S3 bucket"
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
