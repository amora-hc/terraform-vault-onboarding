resource "time_sleep" "wait_for_namespace" {
  depends_on       = [module.prd_namespace]
  create_duration = "10s"  # Wait for 10 seconds
}

resource "vault_mount" "kv" {
  provider   = vault.prd
  depends_on = [time_sleep.wait_for_namespace]
  path       = "secret"
  type       = "kv"
}

resource "time_sleep" "wait_for_mount" {
  depends_on       = [vault_mount.kv]
  create_duration = "10s"  # Wait for 10 seconds
}

resource "vault_generic_secret" "secret" {
  provider   = vault.prd
  depends_on = [time_sleep.wait_for_mount]
  path       = "secret/prd"
  data_json  = <<EOT
  {
    "username": "prd-pass",
    "password": "password123"
  }
  EOT
}