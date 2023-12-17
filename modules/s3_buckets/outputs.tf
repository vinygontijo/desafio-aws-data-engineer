output "meu_bucket_name" {
  value = aws_s3_bucket.meu_bucket.bucket
}

output "meu_bucket_arn" {
  value = aws_s3_bucket.meu_bucket.arn
}

output "bucket_script_path" {
  value = "s3://${aws_s3_bucket.meu_bucket.bucket}/scripts_glue/script-job-glue-acs-bureau.py"
}
