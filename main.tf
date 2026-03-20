data "aws_kms_key" "backend" {
  key_id = "alias/${var.kms_alias}"
}

resource "aws_iam_role" "main" {
  name = var.rolename

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : var.delegate_principals
        },
        "Action" : "sts:AssumeRole",
      }
    ]
  })

}

resource "aws_iam_role_policy" "main" {
  name = "AllowAccessToBackendBucket"
  role = aws_iam_role.main.id

  # see: https://www.terraform.io/docs/language/settings/backends/s3.html#s3-bucket-permissions
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowS3ObjectAccess",
        "Effect" : "Allow"
        "Action" : [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject", # NOTE: required for delete workspace
        ]
        "Resource" : ["${var.s3_bucket_arn}/*"]
      },
      {
        "Sid" : "AllowS3BucketAccess",
        "Effect" : "Allow"
        "Action" : [
          "s3:ListBucket",
        ]
        "Resource" : [var.s3_bucket_arn]
      },
      {
        "Sid" : "AllowKmsAccess",
        "Action" : [
          "kms:Decrypt",
          "kms:Encrypt",
          "kms:GenerateDataKey",
        ]
        "Effect" : "Allow"
        "Resource" : [data.aws_kms_key.backend.arn]
      },
    ]
  })
}
