resource "aws_s3_bucket" "meu_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
    Managedby   = "Terraform"
    Autor       = var.autor
  }
}

resource "aws_s3_object" "placeholder" {
  for_each = toset(["raw/", "scripts_glue/", "curated/", "enriched/"])

  bucket = aws_s3_bucket.meu_bucket.bucket
  key    = each.value
  content = ""
}

resource "aws_s3_object" "glue_script" {
  bucket = aws_s3_bucket.meu_bucket.bucket
  key    = "scripts_glue/script-job-glue-acs-bureau.py"
  source = "${path.root}/glue_scripts/script-job-glue-acs-bureau.py"
}

resource "aws_s3_object" "glue_script_redshift" {
  bucket = aws_s3_bucket.meu_bucket.bucket
  key    = "scripts_glue/script-job-glue-redshift.py"
  source = "${path.root}/glue_scripts/script-job-glue-redshift.py"
}
