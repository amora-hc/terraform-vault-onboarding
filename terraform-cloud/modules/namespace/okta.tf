# Delegate namespace group admin
# https://developer.hashicorp.com/vault/tutorials/enterprise/namespaces
data "okta_group" "namespace_admin" {
  #name     = var.admin_group_name
  for_each = var.create_okta_resources ? { admin = var.admin_group_name } : {}
  name     = each.value
}

data "vault_auth_backend" "okta" {
  #path = var.okta_auth_path
  for_each = var.create_okta_resources ? { path = var.okta_auth_path } : {}
  path     = each.value
}

resource "vault_identity_group" "namespace_admin_external" {
  count = var.create_okta_resources ? 1 : 0
  name  = "${data.okta_group.namespace_admin["admin"].name}-external"
  type  = "external"
}

resource "vault_identity_group_alias" "namespace_admin_external" {
  count          = var.create_okta_resources ? 1 : 0
  name           = var.admin_group_name
  mount_accessor = data.vault_auth_backend.okta["path"].accessor
  canonical_id   = vault_identity_group.namespace_admin_external[0].id
}

resource "vault_policy" "namespace_admin" {
  count     = var.create_okta_resources ? 1 : 0
  namespace = vault_namespace.default.path
  name      = "namespace-admin"
  policy    = file("./${path.module}/../../policies/namespace_admin_policy.hcl")
}

resource "vault_identity_group" "namespace_admin_internal" {
  count            = var.create_okta_resources ? 1 : 0
  namespace        = vault_namespace.default.path
  name             = data.okta_group.namespace_admin["admin"].name
  member_group_ids = [vault_identity_group.namespace_admin_external[0].id]
  policies         = [vault_policy.namespace_admin[0].name]
}
