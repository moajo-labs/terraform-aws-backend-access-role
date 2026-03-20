# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

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
