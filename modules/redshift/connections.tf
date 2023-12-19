# modules/redshift/connections.tf

resource "aws_glue_connection" "redshift_connection" {
  name = "redshift-connection"

  connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:redshift://${aws_redshift_cluster.redshift_cluster.endpoint}:5439/${aws_redshift_cluster.redshift_cluster.database_name}"
    USERNAME            = aws_redshift_cluster.redshift_cluster.master_username
    PASSWORD            = aws_redshift_cluster.redshift_cluster.master_password
  }

  physical_connection_requirements {
    availability_zone      = "us-east-1a" // Substitua pela availability zone adequada
    security_group_id_list = [var.security_group_id]
    subnet_id              = element(var.subnet_ids, 0) // Utiliza o primeiro ID da lista de subnets
  }
}
