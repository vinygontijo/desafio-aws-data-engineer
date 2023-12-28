resource "aws_security_group" "redshift_sg" {
  name        = "redshift-sg"
  description = "Security group for Redshift cluster"
  vpc_id      = var.vpc_id

  tags = {
    Name = "redshift-sg"
  }
}

resource "aws_security_group" "lambda_sg" {
  name        = "lambda-sg"
  description = "Security group for Lambda function"
  vpc_id      = var.vpc_id

  tags = {
    Name = "lambda-sg"
  }
}


resource "aws_security_group_rule" "redshift_ingress_from_lambda" {
  type                     = "ingress"
  from_port                = 5439
  to_port                  = 5439
  protocol                 = "tcp"
  security_group_id        = aws_security_group.redshift_sg.id
  source_security_group_id = aws_security_group.lambda_sg.id
}

# Verifique se a regra de egresso está correta
#resource "aws_security_group_rule" "lambda_egress_to_redshift" {
#  type              = "egress"
#  from_port         = 5439
#  to_port           = 5439
#  protocol          = "tcp"
#  security_group_id = aws_security_group.lambda_sg.id
#  cidr_blocks       = ["${var.vpc_cidr_block}"]
#}



# Regra de saída (egress) do grupo de segurança da Lambda para o Redshift
#resource "aws_security_group_rule" "lambda_egress_to_redshift" {
#  type              = "egress"
#  from_port         = 5439
#  to_port           = 5439
#  protocol          = "tcp"
#  security_group_id = aws_security_group.lambda_sg.id
  # Use o ID do grupo de segurança do Redshift
#  source_security_group_id = aws_security_group.redshift_sg.id
#}


resource "aws_security_group_rule" "lambda_egress_to_redshift" {
  type              = "egress"
  from_port         = 5439
  to_port           = 5439
  protocol          = "tcp"
  security_group_id = aws_security_group.lambda_sg.id
  cidr_blocks       = ["${var.redshift_cidr_block}"]
}
