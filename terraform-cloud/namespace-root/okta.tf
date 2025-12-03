data "okta_auth_server" "default" {
  for_each = var.create_okta_resources ? { vault = "vault" } : {}
  name     = each.value
}

data "okta_app_oauth" "default" {
  for_each = var.create_okta_resources ? { vault_oidc = "HashiCorp Vault OIDC" } : {}
  label    = each.value
}

data "okta_group" "mgmt" {
  for_each = var.create_okta_resources ? toset(var.okta_mgmt_groups) : toset([])
  name     = each.value
}

resource "vault_identity_group" "vault_user" {
  count             = var.create_okta_resources ? 1 : 0
  name              = "${data.okta_group.mgmt["vault-user"].name}-external"
  type              = "external"
  external_policies = true
}

resource "vault_identity_group_alias" "vault_user" {
  count          = var.create_okta_resources ? 1 : 0
  name           = data.okta_group.mgmt["vault-user"].name
  mount_accessor = vault_jwt_auth_backend.okta[0].accessor
  canonical_id   = vault_identity_group.vault_user[0].id
}

resource "vault_identity_group" "vault_admin" {
  count             = var.create_okta_resources ? 1 : 0
  name              = "${data.okta_group.mgmt["vault-admin"].name}-external"
  type              = "external"
  external_policies = true
}

resource "vault_identity_group_alias" "vault_admin" {
  count          = var.create_okta_resources ? 1 : 0
  name           = data.okta_group.mgmt["vault-admin"].name
  mount_accessor = vault_jwt_auth_backend.okta[0].accessor
  canonical_id   = vault_identity_group.vault_admin[0].id
}

resource "vault_identity_group_policies" "vault_admin" {
  count     = var.create_okta_resources ? 1 : 0
  group_id  = vault_identity_group.vault_admin[0].id
  exclusive = false
  policies  = ["okta-vault-admin"]
}

resource "vault_jwt_auth_backend" "okta" {
  count              = var.create_okta_resources ? 1 : 0
  description        = "Okta OIDC Auth Method"
  path               = var.okta_auth_path
  type               = "oidc"
  default_role       = "okta-group"
  bound_issuer       = data.okta_auth_server.default["vault"].issuer
  oidc_discovery_url = "https://${var.okta_org_name}.${var.okta_base_url}"
  oidc_client_id     = data.okta_app_oauth.default["vault_oidc"].client_id
  oidc_client_secret = data.okta_app_oauth.default["vault_oidc"].client_secret

  tune {
    default_lease_ttl = "8h"
    max_lease_ttl     = "24h"
    token_type        = "default-service"
  }
}

resource "vault_jwt_auth_backend_role" "okta_group" {
  count                 = var.create_okta_resources ? 1 : 0
  backend               = vault_jwt_auth_backend.okta[0].path
  role_type             = vault_jwt_auth_backend.okta[0].type
  role_name             = "okta-group"
  bound_audiences       = local.okta_audiences
  bound_claims_type     = "glob"
  allowed_redirect_uris = data.okta_app_oauth.default["vault_oidc"].redirect_uris
  user_claim            = "sub"
  oidc_scopes           = ["profile", "groups"]
  groups_claim          = "groups"
  token_policies        = ["default"]

  claim_mappings = {
    email       = "email"
    name        = "name"
    given_name  = "first_name"
    middle_name = "middle_name"
    family_name = "last_name"
    okta_app_id = "aud"
    issuer      = "iss"
  }
}

resource "vault_policy" "okta_vault_admin" {
  count  = var.create_okta_resources ? 1 : 0
  name   = "okta-vault-admin"
  policy = file("./${path.module}/../policies/okta_vault_admin_policy.hcl")
}
