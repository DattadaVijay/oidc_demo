resource "azurerm_resource_group" "demo" {
  name     = "rg-databricks-oidc-demo"
  location = "canadacentral"
}

resource "azurerm_databricks_workspace" "demo" {
  name                = "adb-oidc-demo"
  resource_group_name = azurerm_resource_group.demo.name
  location            = azurerm_resource_group.demo.location
  sku                 = "premium"

  managed_resource_group_name   = "rg-databricks-oidc-demo-managed"
  public_network_access_enabled = true
}

resource "azuread_application" "github" {
  display_name = "github-databricks-demo"
}

resource "azuread_service_principal" "github" {
  client_id = azuread_application.github.client_id
}

resource "azuread_application_federated_identity_credential" "github" {
  application_id = azuread_application.github.id
  display_name   = "github-main"

  issuer    = "https://token.actions.githubusercontent.com"
  audiences = ["api://AzureADTokenExchange"]

  subject = "repo:DattadaVijay@190878883/oidc_demo@1456956323:ref:refs/heads/main"
}

resource "databricks_service_principal" "github" {
  application_id   = azuread_service_principal.github.client_id
  display_name     = "github-databricks-demo"
  workspace_access = true
}