module "dev" {
  source              = "./../modules/namespace"
  namespace           = "dev"
  description         = "dev namespace"
  admin_group_name    = "vault-dev-admin"
  quota_lease_count   = 201
  quota_rate_limit    = 202
  github_organization = var.github_organization
  okta_api_token      = var.okta_api_token
  okta_org_name       = var.okta_org_name
  tfc_organization    = var.tfc_organization
  vault_address       = var.vault_address
}