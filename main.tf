data "aws_s3_bucket" "backend" {
  bucket = var.s3_bucket_name
}

locals {
  s3_bucket_arn = data.aws_s3_bucket.backend.arn
  use_kms       = var.kms_key_arn != null
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
    "Statement" : concat(
      [
        {
          "Sid" : "AllowS3ObjectAccess",
          "Effect" : "Allow"
          "Action" : [
            "s3:GetObject",
            "s3:PutObject",
            "s3:DeleteObject", # NOTE: required for delete workspace
          ]
          "Resource" : ["${local.s3_bucket_arn}/*"]
        },
        {
          "Sid" : "AllowS3BucketAccess",
          "Effect" : "Allow"
          "Action" : [
            "s3:ListBucket",
          ]
          "Resource" : [local.s3_bucket_arn]
        },
      ],
      local.use_kms ? [
        {
          "Sid" : "AllowKmsAccess",
          "Action" : [
            "kms:Decrypt",
            "kms:Encrypt",
            "kms:GenerateDataKey",
          ]
          "Effect" : "Allow"
          "Resource" : [var.kms_key_arn]
        },
      ] : []
    )
  })
}
