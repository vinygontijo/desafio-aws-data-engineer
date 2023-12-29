resource "aws_glue_job" "example" {
  name       = var.job_name_1
  role_arn   = var.role_arn  

  command {
    name            = "glueetl"
    script_location = "s3://${var.s3_bucket_name}/${var.script_path_1}"
    python_version  = var.python_version
  }

  glue_version     = var.glue_version
  max_retries      = var.max_retries

  default_arguments = merge(
    {
      "--TempDir" = "s3://${var.s3_bucket_name}/temp-dir",
      "--JOB_NAME" = var.job_name_1,
    },
    var.default_arguments
  )
}

resource "aws_glue_job" "desafio_vini" {
  name       = var.job_name_2
  role_arn   = var.role_arn  

  command {
    name            = "glueetl"
    script_location = "s3://${var.s3_bucket_name}/${var.script_path_2}"
    python_version  = var.python_version
  }

  glue_version     = var.glue_version
  max_retries      = var.max_retries

  default_arguments = merge(
    {
      "--TempDir" = "s3://${var.s3_bucket_name}/temp-dir",
      "--JOB_NAME" = var.job_name_2,
    },
    var.default_arguments
  )

  connections = ["redshift-connection"]  
}
