provider "okta" {
  # api_token = var.okta_api_token .env
  org_name = var.okta_org_name
  base_url = var.okta_base_url
}

provider "vault" {
  # address = var.vault_address .env
}