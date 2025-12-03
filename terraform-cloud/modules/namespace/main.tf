resource "vault_namespace" "default" {
  path = var.namespace
  custom_metadata = {
    created-by  = "Terraform onboarding provisioner"
    description = var.description
  }
}

resource "vault_quota_rate_limit" "namespace" {
  name     = vault_namespace.default.path
  path     = "${var.namespace}/"
  interval = 30
  rate     = var.quota_rate_limit
}

resource "vault_quota_lease_count" "namespace" {
  name       = vault_namespace.default.path
  path       = "${var.namespace}/"
  max_leases = var.quota_lease_count
}