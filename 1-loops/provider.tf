terraform {
  # Required providers ensures the referenced providers are installed and available when executing the templates.
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.1.0"
    }
  }
}

provider "azurerm" {
  features {}
}
