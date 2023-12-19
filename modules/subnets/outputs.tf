output "subnet_ids" {
  value = [for subnet in aws_subnet.redshift_subnet : subnet.id]
}
