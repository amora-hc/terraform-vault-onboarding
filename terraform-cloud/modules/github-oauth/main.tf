resource "tfe_oauth_client" "default" {
  name             = "GitHub-OAuth"
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  service_provider = "github"
  organization     = var.tfc_organization
  oauth_token      = var.github_oauth_token
}