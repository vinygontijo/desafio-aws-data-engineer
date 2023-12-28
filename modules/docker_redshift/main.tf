resource "null_resource" "build_redshift_docker_image" {
  provisioner "local-exec" {
    command = "docker build -t redshift_table_creator ."
    working_dir = "${path.module}"
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}

resource "null_resource" "run_redshift_docker_container" {
  depends_on = [null_resource.build_redshift_docker_image]

  provisioner "local-exec" {
    command = "docker run --rm -v ${var.aws_credentials_volume}:/root/.aws -e REDSHIFT_ENDPOINT=${var.redshift_endpoint} -e REDSHIFT_CLUSTER_IDENTIFIER=${var.redshift_cluster_identifier} -e DATABASE_NAME=${var.database_name} -e MASTER_USERNAME=${var.master_username} -e MASTER_PASSWORD=${var.master_password} -e AWS_REGION=${var.aws_region} redshift_table_creator"
    working_dir = "${path.module}"
  }

  triggers = {
    always_run = "${timestamp()}"
    redshift_cluster_endpoint = var.redshift_endpoint
    redshift_cluster_identifier = var.redshift_cluster_identifier
  }
}
