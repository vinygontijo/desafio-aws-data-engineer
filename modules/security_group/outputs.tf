output "security_group_id" {
  value = aws_security_group.redshift_sg.id
}


output "lambda_security_group_id" {
  value = aws_security_group.lambda_sg.id
}

