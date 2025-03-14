module "tst_namespace" {
  source            = "./../modules/namespace"
  namespace         = "tst"
  description       = "tst namespace"
  admin_group_name  = "vault-tst-admin"
  quota_lease_count = 201
  quota_rate_limit  = 202
}