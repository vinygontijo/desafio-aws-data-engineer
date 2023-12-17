# main.tf na raiz do seu projeto

module "s3_bucket" {
  source      = "./modules/s3_buckets"
  bucket_name = "dados-acs-bureau"
  environment = "Dev"
  autor       = "Vinícius Lucas"
}


module "glue_job" {
  source = "./modules/glue"

  job_name       = "00-job-glue-acs-bureau"
  role_arn       = module.iam.job_glue_role_arn
  s3_bucket_name = module.s3_bucket.meu_bucket_name
  script_path    = "scripts_glue/script-job-glue-acs-bureau.py"
  // As variáveis restantes são puxadas dos valores padrão definidos em `variables.tf`
}

module "iam" {
  source = "./modules/iam"

  s3_bucket_name             = "dados-acs-bureau"
  destination_s3_bucket_name = "dados-acs-bureau"
  iam_role_name              = "glue-job-access"
  aws_account_id             = "763589538001"
  user_junior_name           = "user_junior"
  user_develop_name          = "user_develop"
  user_analytics_name        = "user_analytics"
}

module "glue_crawler_acs_bureau" {
  source                = "./modules/glue_crawler"
  glue_service_role_arn = module.iam.job_glue_role_arn
  s3_target_path        = "s3://dados-acs-bureau/raw/" # Valor passado aqui
  database_name         = "dw_acs"
}

