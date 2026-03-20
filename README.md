# terraform-aws-backend-access-role

IAM role with minimal permissions to access a Terraform S3 backend created by [terraform-aws-backend-s3-bucket](https://github.com/moajo-labs/terraform-aws-backend-s3-bucket).

## Features

- IAM role with least-privilege inline policy
- S3 object access (GetObject, PutObject, DeleteObject) and bucket listing
- KMS key access (Decrypt, Encrypt, GenerateDataKey) for encrypted state
- Configurable assume role principals

## Usage

```hcl
module "terraform_backend" {
  source      = "github.com/moajo-labs/terraform-aws-backend-s3-bucket.git?ref=v3.0.0"
  bucket_name = "my-terraform-backend"
}

module "terraform_backend_role" {
  source        = "github.com/moajo-labs/terraform-aws-backend-access-role.git?ref=v3.0.0"
  rolename      = "terraform-backend-accessor"
  s3_bucket_arn = module.terraform_backend.bucket_arn

  delegate_principals = [
    "arn:aws:iam::123456789000:user/example", # Allow single user
    # "123456789000", # Allow all users in account
  ]
}
```

See [`examples/`](./examples/) for complete usage examples.

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                     | Version |
| ------------------------------------------------------------------------ | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.0  |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | ~> 5.0  |

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | ~> 5.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                    | Type        |
| ----------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_iam_role.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)               | resource    |
| [aws_iam_role_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource    |
| [aws_kms_key.backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key)           | data source |

## Inputs

| Name                                                                                       | Description                                          | Type           | Default          | Required |
| ------------------------------------------------------------------------------------------ | ---------------------------------------------------- | -------------- | ---------------- | :------: |
| <a name="input_delegate_principals"></a> [delegate_principals](#input_delegate_principals) | List of principals to allow for sts:AssumeRole       | `list(string)` | n/a              |   yes    |
| <a name="input_kms_alias"></a> [kms_alias](#input_kms_alias)                               | Alias for the KMS key used to encrypt the S3 bucket. | `string`       | `"s3-terraform"` |    no    |
| <a name="input_rolename"></a> [rolename](#input_rolename)                                  | Name of the role.                                    | `string`       | n/a              |   yes    |
| <a name="input_s3_bucket_arn"></a> [s3_bucket_arn](#input_s3_bucket_arn)                   | ARN of S3 bucket for store tfstate.                  | `string`       | n/a              |   yes    |

## Outputs

| Name                                                        | Description         |
| ----------------------------------------------------------- | ------------------- |
| <a name="output_role_arn"></a> [role_arn](#output_role_arn) | ARN of created role |

<!-- END_TF_DOCS -->
