variable "rolename" {
  type        = string
  description = "Name of the role."
}
variable "s3_bucket_name" {
  type        = string
  description = "Name of the S3 bucket for storing tfstate."
}
variable "kms_key_arn" {
  type        = string
  default     = null
  description = "ARN of the KMS key used to encrypt the S3 bucket. If null, KMS permissions are not granted."
}
variable "delegate_principals" {
  type        = list(string)
  description = "List of principals to allow for sts:AssumeRole"
}
