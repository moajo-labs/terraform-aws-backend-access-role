mock_provider "aws" {}

variables {
  rolename       = "test-backend-accessor"
  s3_bucket_name = "test-terraform-backend"
  delegate_principals = [
    "arn:aws:iam::123456789000:user/test-user",
  ]
}

run "creates_iam_role_with_correct_name" {
  command = plan

  assert {
    condition     = aws_iam_role.main.name == "test-backend-accessor"
    error_message = "Role name should match the rolename variable"
  }
}

run "without_kms_key" {
  command = plan

  assert {
    condition     = aws_iam_role_policy.main.name == "AllowAccessToBackendBucket"
    error_message = "Policy should be created without KMS key"
  }
}

run "with_kms_key" {
  command = plan

  variables {
    kms_key_arn = "arn:aws:kms:ap-northeast-1:123456789000:key/test-key-id"
  }

  assert {
    condition     = aws_iam_role_policy.main.name == "AllowAccessToBackendBucket"
    error_message = "Policy should be created with KMS key"
  }
}
