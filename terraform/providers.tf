terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }

    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "dac71ca1-6c30-4bf7-8de9-0731b4e02a22"
  tenant_id       = "547cf1be-9269-49d5-9bb5-3f7628065353"
}

provider "azuread" {
  tenant_id = "547cf1be-9269-49d5-9bb5-3f7628065353"
}

provider "databricks" {
  host = "https://${azurerm_databricks_workspace.demo.workspace_url}"

  azure_workspace_resource_id = azurerm_databricks_workspace.demo.id
  auth_type                   = "azure-cli"
}