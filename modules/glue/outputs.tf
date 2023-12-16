output "glue_job_name" {
  description = "The name of the Glue job"
  value       = aws_glue_job.example.name
}

output "glue_job_arn" {
  description = "The ARN of the Glue job"
  value       = aws_glue_job.example.arn
}
