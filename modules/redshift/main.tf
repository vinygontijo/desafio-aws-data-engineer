resource "aws_redshift_subnet_group" "redshift_subnet_group" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids

  tags = {
    Name = var.subnet_group_name
  }
}

resource "aws_redshift_cluster" "redshift_cluster" {
  cluster_identifier         = var.cluster_identifier
  database_name              = var.database_name
  master_username            = var.master_username
  master_password            = var.master_password
  node_type                  = var.node_type
  cluster_type               = var.cluster_type
  number_of_nodes            = var.number_of_nodes
  cluster_subnet_group_name  = aws_redshift_subnet_group.redshift_subnet_group.name
  skip_final_snapshot        = var.skip_final_snapshot
  publicly_accessible        = var.publicly_accessible
}
