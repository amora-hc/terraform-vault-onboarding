module "tfe_oauth_client" {
  source             = "./../modules/github-oauth"
  tfc_organization   = var.tfc_organization
  github_oauth_token = var.github_oauth_token
}

module "tfe_workspace" {
  source                = "./../modules/tfe-workspace"
  enable_tfc_agent_pool = var.enable_tfc_agent_pool
  github_organization   = var.github_organization
  github_repository     = var.github_repository
  vault_address         = var.vault_address_tfc_agent
  okta_api_token        = var.okta_api_token
  okta_org_name         = var.okta_org_name
  okta_base_url         = var.okta_base_url
  tfc_organization      = var.tfc_organization
  tfc_project           = var.tfc_project
  tfc_workspace         = var.tfc_workspace
  tfc_working_directory = var.tfc_working_directory
  tfe_oauth_client      = module.tfe_oauth_client.tfe_oauth_client
  # vault_address           = var.vault_address
  vault_auth_path = vault_jwt_auth_backend.tfc.path
  vault_auth_role = "${var.vault_auth_role}-baseline-configuration"
  vault_policy    = vault_policy.tfc_admin.name
}

module "tfe_workspace_namespace_vending" {
  source                = "./../modules/tfe-workspace"
  enable_tfc_agent_pool = var.enable_tfc_agent_pool
  github_organization   = var.github_organization
  github_repository     = var.github_repository
  vault_address         = var.vault_address_tfc_agent
  okta_api_token        = var.okta_api_token
  okta_org_name         = var.okta_org_name
  okta_base_url         = var.okta_base_url
  tfc_organization      = var.tfc_organization
  tfc_project           = var.tfc_project
  tfc_workspace         = "terraform-vault-onboarding-namespace-vending"
  tfc_working_directory = "terraform-cloud/namespace-vending"
  tfe_oauth_client      = module.tfe_oauth_client.tfe_oauth_client
  # vault_address           = var.vault_address
  vault_auth_path = vault_jwt_auth_backend.tfc.path
  vault_auth_role = "${var.vault_auth_role}-namespace-vending"
  vault_policy    = vault_policy.tfc_admin.name
}