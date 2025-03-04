variable "namespace" {
  type = string
}

variable "description" {
  type = string
}

variable "admin_group_name" {
  type = string
}

variable "quota_lease_count" {
  type    = string
  default = 100
}

variable "quota_rate_limit" {
  type    = string
  default = 100
}

variable "github_organization" {
  type        = string
  description = "Name of the GitHub organization."
}

variable "github_repository" {
  type        = string
  description = "Name of the GitHub repository."
  default     = "terraform-vault-onboarding"
}

variable "tfc_organization" {
  type        = string
  description = "Name of the TFC organization."
}

variable "tfc_project" {
  type        = string
  description = "Name of the TFC project."
  default     = "default project"
}

variable "tfc_workspace" {
  type        = string
  description = "Name of the TFC workspace."
  default     = "terraform-vault-onboarding-baseline-configuration"
  #default = "terraform-vault-onboarding-bootstrap"
}

variable "tfc_working_directory" {
  type        = string
  description = "Working directory for the TFC workspace."
  default     = "terraform-cloud/baseline-configuration"
  #default = "terraform-cloud/bootstrap"
}

variable "vault_address" {
  type        = string
  description = "Vault API endpoint"
}

variable "vault_address_tfc_agent" {
  type        = string
  description = "Vault API endpoint for TFC agent"
}

variable "vault_auth_role" {
  type        = string
  description = "Vault role name"
  default     = "tfc-admin"
}

variable "okta_org_name" {
  type        = string
  description = "Okta organization name"
}

variable "okta_base_url" {
  type        = string
  description = "Okta base URL"
  default     = "okta.com"
}

variable "okta_users" {
  type = map(object({
    first_name = string
    last_name  = string
    password   = string
    groups     = list(string)
  }))
  default = {}
}

variable "okta_api_token" {
  type        = string
  description = "Okta API token"
}

variable "enable_tfc_agent_pool" {
  type    = bool
  default = false
}