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

variable "create_okta_resources" {
  type        = bool
  default     = false
  description = "Whether to create Okta-related variables and resources"
}

variable "okta_auth_path" {
  type    = string
  default = "oidc"
}
