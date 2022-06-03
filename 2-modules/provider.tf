terraform {
  # Required providers ensures the referenced providers are installed and available when executing the templates.
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.1.0"
    }
  }

  # Backends define where and how operations are performed. REF: https://www.terraform.io/docs/language/settings/backends/index.html
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

# Commands to run
# terraform init -backend-config="key=2modules.tfstate" -backend-config="container_name=state" -backend-config="storage_account_name=sltfstatestg" -backend-config="resource_group_name=TF-STATE-RGP"
# terraform apply
