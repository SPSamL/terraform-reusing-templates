terraform {
  # Required providers ensures the referenced providers are installed and available when executing the templates.
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.1.0"
    }
  }

  # Backends define where and how operations are performed. REF: https://www.terraform.io/docs/language/settings/backends/index.html
  backend "azurerm" {
    resource_group_name  = "TF-STATE-RGP"
    storage_account_name = "sltfstatestg"
    container_name       = "state"
    key                  = "2modules.tfstate"
  }
}

provider "azurerm" {
  features {}
}
