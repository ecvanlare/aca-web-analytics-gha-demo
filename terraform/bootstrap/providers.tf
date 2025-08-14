# Terraform configuration for Web Analytics (Umami) bootstrap infrastructure
# This file defines the required providers and their versions

terraform {
  required_version = ">= 1.12.1"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.37"
    }
  }
}

provider "azurerm" {
  features {}
} 