output "subnet_ids" {
  value = [for s in aws_subnet.redshift_subnet : s.id]
}
