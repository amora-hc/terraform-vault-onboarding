module "prd_namespace" {
  source            = "./../modules/namespace"
  namespace         = "prd"
  description       = "prd namespace"
  admin_group_name  = "vault-prd-admin"
  quota_lease_count = 201
  quota_rate_limit  = 202
}