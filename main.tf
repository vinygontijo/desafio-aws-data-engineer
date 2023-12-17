# main.tf na raiz do seu projeto

module "s3_bucket" {
  source = "./modules/s3_buckets"

  bucket_name = "bucket-desafio-viny"
  environment = "Dev"
  autor       = "Vinícius Lucas"
}


module "glue_job" {
  source = "./modules/glue"

  job_name       = "00-job-glue-acs-bureau"
  role_arn       = module.iam.job_glue_role_arn
  s3_bucket_name = "lecture-athena"
  script_path    = "script-job-glue-acs-bureau.py"
  // As variáveis restantes são puxadas dos valores padrão definidos em `variables.tf`
}

module "iam" {
  source = "./modules/iam"

  s3_bucket_name = "lecture-athena"
  destination_s3_bucket_name = "letrus-educacao-pdde-teste"
  iam_role_name  = "glue-job-access"
  aws_account_id = "763589538001"
}

module "glue_crawler_acs_bureau" {
  source               = "./modules/glue_crawler"
  glue_service_role_arn = module.iam.job_glue_role_arn
  s3_target_path       = "s3://letrus-educacao-pdde-teste/raw/" # Valor passado aqui
  database_name        = "dw_acs"
}
