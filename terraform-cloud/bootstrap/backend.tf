terraform {
  cloud {
    organization = "amora-hc"
    workspaces {
      name    = "terraform-vault-onboarding-bootstrap"
      project = "vault-onboarding"
    }
  }
}
