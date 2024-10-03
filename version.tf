terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.90.0"
    }
    azapi = {
      source = "Azure/azapi"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

provider "azapi" {
  use_oidc = true
}

provider "azurerm" {
  features {}
  alias                      = "app_dev"
  subscription_id            = var.app_dev_subid
  skip_provider_registration = true
}
