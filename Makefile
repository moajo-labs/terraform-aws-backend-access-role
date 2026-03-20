.PHONY: init fmt validate test docs clean

init: ## Initialize Terraform
	terraform init

fmt: ## Format Terraform files
	terraform fmt

validate: init ## Validate Terraform configuration
	terraform validate

test: ## Run Terraform tests
	terraform test

docs: ## Update README.md with terraform-docs
	terraform-docs .

clean: ## Remove .terraform directory
	rm -rf .terraform .terraform.lock.hcl
