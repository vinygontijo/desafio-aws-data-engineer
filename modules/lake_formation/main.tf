resource "aws_lakeformation_permissions" "permissions_junior_enriched" {
  principal = aws_iam_user.user_junior.arn
  permissions = ["SELECT", "ALTER", "DROP", "INSERT"]
  permissions_with_grant_option = ["SELECT", "ALTER", "DROP", "INSERT"]
  data_location {
    arn = "arn:aws:s3:::dados-acs-bureau/enriched/*"
  }
}

resource "aws_lakeformation_permissions" "permissions_junior_curated" {
  principal = aws_iam_user.user_junior.arn
  permissions = ["SELECT", "INSERT"]
  permissions_with_grant_option = ["SELECT", "INSERT"]
  data_location {
    arn = "arn:aws:s3:::dados-acs-bureau/curated/*"
  }
}

resource "aws_lakeformation_permissions" "permissions_develop" {
  principal = aws_iam_user.user_develop.arn
  permissions = ["ALL"]
  permissions_with_grant_option = ["ALL"]
  data_location {
    arn = "arn:aws:s3:::dados-acs-bureau/*"
  }
}

resource "aws_lakeformation_permissions" "permissions_analytics" {
  principal = aws_iam_user.user_analytics.arn
  permissions = ["SELECT"]
  data_location {
    arn = "arn:aws:s3:::dados-acs-bureau/curated/*"
  }
}
