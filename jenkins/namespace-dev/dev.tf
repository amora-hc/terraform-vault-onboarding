module "dev_namespace" {
  source            = "./../modules/namespace"
  namespace         = "dev"
  description       = "dev namespace"
  admin_group_name  = "vault-dev-admin"
  quota_lease_count = 201
  quota_rate_limit  = 202
}