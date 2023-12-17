resource "aws_glue_job" "example" {
  name       = var.job_name
  role_arn   = var.role_arn
  depends_on = [aws_s3_object.glue_script]

  command {
    name            = "glueetl"
    script_location = "s3://${var.s3_bucket_name}/${var.script_path}"
    python_version  = var.python_version
  }

  glue_version     = var.glue_version
  max_retries      = var.max_retries

  default_arguments = merge(
    {
      "--TempDir" = "s3://${var.s3_bucket_name}/temp-dir",
      "--JOB_NAME" = var.job_name,
    },
    var.default_arguments
  )
}
