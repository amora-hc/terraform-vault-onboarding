provider "okta" {
  # api_token = var.okta_api_token .env
  org_name = var.okta_org_name
  base_url = var.okta_base_url
  api_token = var.okta_api_token #delete
}

provider "vault" {
  #  skip_child_token = true
  address = "http://127.0.0.1:8200"  #delete
  token   = var.vault_token  #delete
}
