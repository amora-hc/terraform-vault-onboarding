locals {
  okta_audiences = var.create_okta_resources ? concat(
    tolist(data.okta_auth_server.default["vault"].audiences),
    [data.okta_app_oauth.default["vault_oidc"].client_id]
  ) : []
}

resource "vault_quota_rate_limit" "global" {
  name     = "global"
  path     = ""
  interval = 30
  rate     = 300000
}

# resource "vault_audit" "file" {
#   options = {
#     file_path = "/var/logs/vault_audit.log"
#   }
#   type = "file"
# }

