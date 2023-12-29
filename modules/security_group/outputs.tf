output "security_group_id" {
  value = aws_security_group.redshift_sg.id
}


output "glue_security_group_id" {
  value = aws_security_group.glue_sg.id
}

