provider "aws" {
  region = "ap-northeast-1"
}

module "terraform_backend" {
  source      = "github.com/moajo/terraform-backend-s3-bucket.git?ref=v3.0.0"
  bucket_name = "my-terraform-backend"
}

module "terraform_backend_role" {
  source         = "github.com/moajo/terraform-backend-access-role.git?ref=v3.0.0"
  rolename       = "terraform-backend-accessor"
  s3_bucket_name = module.terraform_backend.bucket_name
  kms_key_arn    = module.terraform_backend.kms_key_arn

  delegate_principals = [
    "arn:aws:iam::123456789000:user/example",
  ]
}

# terraform {
#   backend "s3" {
#     bucket   = "my-terraform-backend"
#     key      = "example/terraform.tfstate"
#     region   = "ap-northeast-1"
#     role_arn = "<module.terraform_backend_role.role_arn>"
#     encrypt  = true
#   }
# }
