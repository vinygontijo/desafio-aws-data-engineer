output "lambda_function_name" {
  description = "The name of the Lambda function."
  value       = aws_lambda_function.lambda_redshift.function_name
}

output "lambda_function_arn" {
  description = "The ARN of the Lambda function."
  value       = aws_lambda_function.lambda_redshift.arn
}

output "lambda_function_invoke_arn" {
  description = "The invoke ARN of the Lambda function."
  value       = aws_lambda_function.lambda_redshift.invoke_arn
}

