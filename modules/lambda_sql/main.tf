
resource "aws_lambda_function" "lambda_redshift" {
  function_name    = "lambda_redshift_execute_sql"
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.8"
  filename         = "${path.module}/lambda_function.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_function.zip")

  role = aws_iam_role.lambda_execution_role.arn

  # Configuração da VPC
  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [var.lambda_security_group_id, var.redshift_security_group_id]
  }
  
  environment {
    variables = {
      DB_HOST     = var.db_host
      DB_NAME     = var.db_name
      DB_PORT     = var.db_port
      DB_USER     = var.db_user
      DB_PASSWORD = var.db_password
    }
  }

  # Aumentando o tempo limite e a memória
  timeout     = 600 # Tempo em segundos
  memory_size = 1024 # Memória em MB

  depends_on = [
    # aws_iam_role_policy_attachment.lambda_vpc_access_attachment,
    aws_iam_role_policy_attachment.attach_redshift_access_lambda,
    aws_iam_role.lambda_execution_role
  ]

}

resource "aws_iam_role_policy_attachment" "lambda_vpc_access_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = var.lambda_vpc_access_policy_arn
}



resource "aws_iam_role_policy_attachment" "attach_redshift_access_lambda" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = var.redshift_policy_arn
}


resource "aws_iam_role" "lambda_execution_role" {
  name               = "lambda_execution_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}
