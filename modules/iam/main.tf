# iam/main.tf


resource "aws_iam_policy" "lambda_vpc_access" {
  name        = "lambda-vpc-access-policy"
  description = "Permite que funções Lambda gerenciem interfaces de rede na VPC"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface",
          "ec2:AssignPrivateIpAddresses",
          "ec2:UnassignPrivateIpAddresses"
        ],
        Effect = "Allow",
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "lambda_vpc_access_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_vpc_access.arn
}


resource "aws_iam_policy" "s3_access" {
  name        = "s3-access-policy"
  description = "Policy that allows access to S3"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ],
        Effect   = "Allow",
        Resource = [
          "arn:aws:s3:::${var.s3_bucket_name}/*",
          "arn:aws:s3:::${var.s3_bucket_name}",
          "arn:aws:s3:::${var.destination_s3_bucket_name}/*",
          "arn:aws:s3:::${var.destination_s3_bucket_name}"
        ]
      },
      {
        Action    = "s3:ListAllMyBuckets",
        Effect    = "Allow",
        Resource  = "*",
        Condition = {
          StringEquals = {
            "aws:RequestedAccount" = var.aws_account_id
          }
        }
      }
    ]
  })
}

resource "aws_iam_role" "job_glue_role" {
  name = "glue-job-access"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "glue.amazonaws.com"
        },
      },
    ],
  })
}

# Altere o nome da role para algo único, como "my_lambda_execution_role"
resource "aws_iam_role" "lambda_execution_role" {
  name = "my_lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com",
        },
        Action = "sts:AssumeRole",
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "attach_redshift_access" {
  role       = aws_iam_role.job_glue_role.name
  policy_arn = aws_iam_policy.redshift_access.arn
}


resource "aws_iam_role_policy_attachment" "attach_s3_access" {
  role       = aws_iam_role.job_glue_role.name
  policy_arn = aws_iam_policy.s3_access.arn
}

resource "aws_iam_role_policy_attachment" "attach_glue_console_full_access" {
  role       = aws_iam_role.job_glue_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSGlueConsoleFullAccess"
}

resource "aws_iam_role_policy_attachment" "attach_glue_service_role" {
  role       = aws_iam_role.job_glue_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

# Criação de usuários

resource "aws_iam_user" "user_junior" {
  name = var.user_junior_name
}

resource "aws_iam_user" "user_develop" {
  name = var.user_develop_name
}

resource "aws_iam_user" "user_analytics" {
  name = var.user_analytics_name
}
