variable "db_host" {
  description = "The endpoint/hostname for the Redshift cluster."
  type        = string
}

variable "db_name" {
  description = "The name of the default database in the Redshift cluster."
  type        = string
}

variable "db_port" {
  description = "The port on which the Redshift cluster is accessible."
  type        = string
}

variable "db_user" {
  description = "The username for the Redshift cluster."
  type        = string
}

variable "db_password" {
  description = "The password for the Redshift cluster."
  type        = string
  sensitive   = true
}

variable "policy_arn" {
  description = "The ARN of the IAM policy to attach to the Lambda function."
  type        = string
}

variable "job_role_name" {
  description = "The name of the IAM role for the job."
  type        = string
}

variable "iam_role_arn" {
  description = "The ARN of the IAM role for the Lambda function."
  type        = string
}

variable "redshift_policy_arn" {
  description = "The ARN of the Redshift access policy."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the Lambda function"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for the Lambda function"
  type        = string
}

variable "lambda_vpc_access_policy_arn" {
  description = "The ARN of the Lambda VPC Access Policy"
  type        = string
}


variable "lambda_security_group_id" {
  description = "Security group ID for the Lambda function"
  type        = string
}


variable "redshift_security_group_id" {
  description = "The security group ID for the Redshift cluster"
  type        = string
}
