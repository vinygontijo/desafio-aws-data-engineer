resource "aws_glue_crawler" "acs_bureau_crawler" {
  name          = "acs-bureau-crawler"
  database_name = aws_glue_catalog_database.dw_acs.name
  role          = var.glue_service_role_arn

  s3_target {
    path = var.s3_target_path
  }

  schema_change_policy {
    delete_behavior = "LOG"
    update_behavior = "UPDATE_IN_DATABASE"
  }


  table_prefix = "tb_"
}

resource "aws_glue_catalog_database" "dw_acs" {
  name = "dw_acs"
}
