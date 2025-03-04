variable "github_organization" {
  type        = string
  description = "Name of the GitHub organization."
}

variable "tfc_organization" {
  type        = string
  description = "Name of the TFC organization."
}

variable "okta_api_token" {
  type        = string
  description = "Okta API token"
}

variable "okta_org_name" {
  type        = string
  description = "Okta organization name"
}

variable "vault_address" {
  type        = string
  description = "Vault API endpoint"
}
