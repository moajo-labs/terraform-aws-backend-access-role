mock_provider "aws" {}

variables {
  rolename      = "test-backend-accessor"
  s3_bucket_arn = "arn:aws:s3:::test-terraform-backend"
  kms_alias     = "s3-terraform"
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

run "kms_alias_defaults_to_s3_terraform" {
  command = plan

  assert {
    condition     = data.aws_kms_key.backend.key_id == "alias/s3-terraform"
    error_message = "KMS key alias should default to alias/s3-terraform"
  }
}

run "custom_kms_alias" {
  command = plan

  variables {
    kms_alias = "custom-key"
  }

  assert {
    condition     = data.aws_kms_key.backend.key_id == "alias/custom-key"
    error_message = "KMS key alias should use the custom alias"
  }
}
