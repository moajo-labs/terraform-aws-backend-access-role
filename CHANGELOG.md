# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

## [0.3.1] - 2026-03-20

### Changed

- Relax AWS provider version constraint from `~> 5.0` to `>= 5.0`

## [0.3.0] - 2026-03-20

### Changed

- Replace `s3_bucket_arn` variable with `s3_bucket_name`, resolving ARN via `data "aws_s3_bucket"`
- Replace `kms_alias` variable with optional `kms_key_arn` (default `null`)
- KMS policy statement is now only included when `kms_key_arn` is provided

## [0.2.1] - 2026-03-20

### Fixed

- Update module link in README to point to Terraform Registry
- Remove outdated "inline" reference from policy description

## [0.2.0] - 2026-03-20

### Changed

- Replace deprecated `inline_policy` with `aws_iam_role_policy` resource

### Added

- Makefile for common development commands

## [0.1.0] - 2026-03-20

### Added

- IAM role with minimal S3 and KMS access for Terraform S3 backend
- CI workflow (GitHub Actions)
- Usage example in `examples/simple/`
- Tests with `terraform test`
