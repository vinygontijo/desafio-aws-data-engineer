output "glue_job_name" {
  description = "The name of the Glue job"
  value       = aws_glue_job.example.name
}

output "glue_job_arn" {
  description = "The ARN of the Glue job"
  value       = aws_glue_job.example.arn
}


output "glue_job_desafio_vini_name" {
  description = "The name of the Glue job for Desafio Vini"
  value       = aws_glue_job.desafio_vini.name
}

output "glue_job_desafio_vini_arn" {
  description = "The ARN of the Glue job for Desafio Vini"
  value       = aws_glue_job.desafio_vini.arn
}
