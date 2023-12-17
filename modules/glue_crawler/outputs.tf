output "glue_crawler_name" {
  description = "The name of the Glue crawler"
  value       = aws_glue_crawler.acs_bureau_crawler.name
}

output "glue_crawler_arn" {
  description = "The ARN of the Glue crawler"
  value       = aws_glue_crawler.acs_bureau_crawler.arn
}
