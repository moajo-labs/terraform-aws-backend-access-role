# terraform-aws-backend-access-role

IAM role with minimal permissions to access a Terraform S3 backend created by [terraform-aws-backend-s3-bucket](https://registry.terraform.io/modules/moajo-labs/backend-s3-bucket/aws/latest).

## Features

- IAM role with least-privilege policy
- S3 object access (GetObject, PutObject, DeleteObject) and bucket listing
- Optional KMS key access (Decrypt, Encrypt, GenerateDataKey) for encrypted state
- Configurable assume role principals

## Usage

```hcl
module "terraform_backend" {
  source      = "moajo-labs/backend-s3-bucket/aws"
  bucket_name = "my-terraform-backend"
}

module "terraform_backend_role" {
  source         = "moajo-labs/backend-access-role/aws"
  rolename       = "terraform-backend-accessor"
  s3_bucket_name = module.terraform_backend.bucket_name
  kms_key_arn    = module.terraform_backend.kms_key_arn # Optional: omit if bucket is not KMS-encrypted

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
| <a name="provider_aws"></a> [aws](#provider_aws) | 5.100.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                    | Type        |
| ----------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_iam_role.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)               | resource    |
| [aws_iam_role_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource    |
| [aws_s3_bucket.backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket)       | data source |

## Inputs

| Name                                                                                       | Description                                                                                 | Type           | Default | Required |
| ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------- | -------------- | ------- | :------: |
| <a name="input_delegate_principals"></a> [delegate_principals](#input_delegate_principals) | List of principals to allow for sts:AssumeRole                                              | `list(string)` | n/a     |   yes    |
| <a name="input_kms_key_arn"></a> [kms_key_arn](#input_kms_key_arn)                         | ARN of the KMS key used to encrypt the S3 bucket. If null, KMS permissions are not granted. | `string`       | `null`  |    no    |
| <a name="input_rolename"></a> [rolename](#input_rolename)                                  | Name of the role.                                                                           | `string`       | n/a     |   yes    |
| <a name="input_s3_bucket_name"></a> [s3_bucket_name](#input_s3_bucket_name)                | Name of the S3 bucket for storing tfstate.                                                  | `string`       | n/a     |   yes    |

## Outputs

| Name                                                        | Description         |
| ----------------------------------------------------------- | ------------------- |
| <a name="output_role_arn"></a> [role_arn](#output_role_arn) | ARN of created role |

<!-- END_TF_DOCS -->
