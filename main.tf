# main.tf na raiz do seu projeto

module "s3_bucket" {
  source      = "./modules/s3_buckets"
  bucket_name = "dados-acs-bureau"
  environment = "Dev"
  autor       = "Vinícius Lucas"
}


module "glue_job" {
  source = "./modules/glue"

  job_name_1     = "00-job-glue-acs-bureau"
  job_name_2     = "01-job-glue-acs-bureau"
  role_arn       = module.iam.job_glue_role_arn
  s3_bucket_name = module.s3_bucket.meu_bucket_name
  script_path_1  = "scripts_glue/script-job-glue-acs-bureau.py"
  script_path_2  = "scripts_glue/script-job-glue-redshift.py"
  // Outras variáveis...
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

module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  vpc_name   = "RedshiftVPC"
  subnet_ids = module.subnets.subnet_ids
}



module "security_group" {
  source                     = "./modules/security_group"
  vpc_id                     = module.vpc.vpc_id
  vpc_cidr_block             = module.vpc.cidr_block
  ingress_cidr_block         = "10.0.0.0/24" # Valor definido diretamente  
  glue_security_group_id   = module.security_group.glue_security_group_id
  redshift_security_group_id = module.redshift.security_group_id
  redshift_cidr_block        = "10.0.0.0/16"
}


module "subnets" {
  source = "./modules/subnets"
  vpc_id = module.vpc.vpc_id
  subnets = {
    "subnet1" = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "us-east-1a"
      name              = "RedshiftSubnet1"
    },
    "subnet2" = {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "us-east-1b"
      name              = "RedshiftSubnet2"
    }
  }
}

module "redshift" {
  source              = "./modules/redshift"
  subnet_group_name   = "redshift-subnet-group"
  subnet_ids          = module.subnets.subnet_ids
  security_group_id   = module.security_group.security_group_id
  cluster_identifier  = "redshift-cluster"
  database_name       = "dw_acs_redshift"
  master_username     = "redshift_admin"
  master_password     = "Acs12345678" # Substitua por um método seguro
  node_type           = "dc2.large"
  cluster_type        = "single-node" # ou "multi-node" se necessário
  number_of_nodes     = 1             # Apenas para clusters multi-node
  skip_final_snapshot = true
  publicly_accessible = true
}



module "s3_vpc_endpoint" {
  source       = "./modules/vpc_endpoint"
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.us-east-1.s3"
}


module "docker_redshift" {
  source = "./modules/docker_redshift"

  aws_credentials_volume      = "/home/viny/.aws"
  redshift_endpoint           = module.redshift.redshift_cluster_endpoint
  redshift_cluster_identifier = module.redshift.cluster_identifier
  database_name               = module.redshift.database_name
  master_username             = module.redshift.master_username
  master_password             = module.redshift.master_password
  aws_region                  = "us-east-1" # A região deve corresponder à sua infraestrutura real
}
