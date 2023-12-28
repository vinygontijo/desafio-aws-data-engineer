# Construir a imagem Docker
resource "null_resource" "build_redshift_docker_image" {
  provisioner "local-exec" {
    command = "docker build -t redshift_table_creator ."
    working_dir = "${path.module}"
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}

# Executar o container Docker
resource "null_resource" "run_redshift_docker_container" {
  depends_on = [null_resource.build_redshift_docker_image]

  provisioner "local-exec" {        
    #command = "docker run --rm -v /home/viny/.aws:/root/.aws -e REDSHIFT_ENDPOINT=${aws_redshift_cluster.redshift_cluster.endpoint} -e DATABASE_NAME=${aws_redshift_cluster.redshift_cluster.database_name} -e MASTER_USERNAME=${aws_redshift_cluster.redshift_cluster.master_username} -e MASTER_PASSWORD=${aws_redshift_cluster.redshift_cluster.master_password} -e AWS_REGION=us-east-1 redshift_table_creator"
    command = "docker run --rm -v /home/viny/.aws:/root/.aws -e REDSHIFT_ENDPOINT=${aws_redshift_cluster.redshift_cluster.endpoint} -e REDSHIFT_CLUSTER_IDENTIFIER=${aws_redshift_cluster.redshift_cluster.cluster_identifier} -e DATABASE_NAME=${aws_redshift_cluster.redshift_cluster.database_name} -e MASTER_USERNAME=${aws_redshift_cluster.redshift_cluster.master_username} -e MASTER_PASSWORD=${aws_redshift_cluster.redshift_cluster.master_password} -e AWS_REGION=us-east-1 redshift_table_creator"
    working_dir = "${path.module}"
  }

  triggers = {
    always_run = "${timestamp()}"
    redshift_cluster_endpoint = aws_redshift_cluster.redshift_cluster.endpoint
    redshift_cluster_identifier = aws_redshift_cluster.redshift_cluster.cluster_identifier
  }
}
