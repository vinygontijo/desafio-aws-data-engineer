output "vpc_id" {
  value = aws_vpc.redshift_vpc.id
}

output "cidr_block" {
  value = aws_vpc.redshift_vpc.cidr_block
}
