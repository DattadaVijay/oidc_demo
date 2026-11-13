output "github_client_id" {
  value = azuread_application.github.client_id
}

output "azure_tenant_id" {
  value = "547cf1be-9269-49d5-9bb5-3f7628065353"
}

output "databricks_host" {
  value = "https://${azurerm_databricks_workspace.demo.workspace_url}"
}