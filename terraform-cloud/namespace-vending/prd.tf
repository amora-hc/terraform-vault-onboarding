module "prd_namespace" {
  source            = "./../modules/namespace"
  namespace         = "prd"
  description       = "prd namespace"
  admin_group_name  = "vault-prd-admin"
  quota_lease_count = 201
  quota_rate_limit  = 202
}

module "prd_workspace" {
  source                = "./../modules/tfe-workspace"
  enable_tfc_agent_pool = var.enable_tfc_agent_pool
  github_organization   = var.github_organization
  github_repository     = var.github_repository
  okta_api_token        = var.okta_api_token
  okta_org_name         = var.okta_org_name
  okta_base_url         = var.okta_base_url
  tfc_organization      = var.tfc_organization
  tfc_project           = var.tfc_project
  tfc_workspace         = "${var.tfc_workspace_prefix}-namespace-prd"
  tfc_working_directory = "${var.tfc_working_directory_prefix}/namespace-prd"
  tfc_terraform_variables = {
    "okta_org_name" = { value = var.okta_org_name }
    "okta_base_url" = { value = var.okta_base_url }
  }
  vault_address   = var.vault_address
  vault_auth_path = var.vault_auth_path
  vault_auth_role = var.vault_auth_role #"tfc-admin-namespace-prd"
  vault_namespace = module.prd_namespace.namespace
}
