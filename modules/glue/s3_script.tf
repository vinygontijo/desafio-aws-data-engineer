resource "aws_s3_object" "glue_script" {
  bucket = var.s3_bucket_name
  key    = var.script_path
  source = "${path.module}/../../glue_scripts/script-job-glue-acs-bureau.py"
  etag   = filemd5("${path.module}/../../glue_scripts/script-job-glue-acs-bureau.py")
}
