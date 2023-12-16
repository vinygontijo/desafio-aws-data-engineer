# modules/s3_buckets/s3_setup.tf

resource "aws_s3_bucket" "meu_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
    Managedby   = "Terraform"
    Autor       = var.autor
  }
}

output "meu_bucket_name" {
  value = aws_s3_bucket.meu_bucket.bucket
}

output "meu_bucket_arn" {
  value = aws_s3_bucket.meu_bucket.arn
}
