# Grupo de Segurança do Redshift
resource "aws_security_group" "redshift_sg" {
  name        = "redshift-sg"
  description = "Security group for Redshift cluster"
  vpc_id      = var.vpc_id
}

# Grupo de Segurança do Glue
resource "aws_security_group" "glue_sg" {
  name        = "glue_sg"
  description = "Security group for AWS Glue"
  vpc_id      = var.vpc_id
}

# Regra de Ingresso para o Glue - Abrir todas as portas para tráfego de entrada
resource "aws_security_group_rule" "glue_ingress" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  security_group_id = aws_security_group.glue_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# Regra de Egresso para o Glue - Abrir todas as portas para tráfego de saída
resource "aws_security_group_rule" "glue_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  security_group_id = aws_security_group.glue_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# Regra de Ingresso para o Redshift - Permitir tráfego do Glue
resource "aws_security_group_rule" "redshift_ingress_from_glue" {
  type                     = "ingress"
  from_port                = 5439
  to_port                  = 5439
  protocol                 = "tcp"
  security_group_id        = aws_security_group.redshift_sg.id
  source_security_group_id = aws_security_group.glue_sg.id
}
