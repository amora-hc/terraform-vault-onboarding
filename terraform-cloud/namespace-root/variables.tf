variable "default_lease_ttl" {
  type        = string
  description = "Default lease TTL for Vault tokens"
  default     = "10m"
}

variable "max_lease_ttl" {
  type        = string
  description = "Maximum lease TTL for Vault tokens"
  default     = "30m"
}

variable "token_type" {
  type        = string
  description = "Token type for Vault tokens"
  default     = "default-service"
}

variable "create_okta_resources" {
  type        = bool
  default     = false
  description = "Whether to create Okta-related variables and resources"
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

variable "okta_auth_path" {
  type    = string
  default = "oidc"
}

variable "okta_mgmt_groups" {
  type = list(string)
  default = [
    "vault-admin",
    "vault-user"
  ]
}
