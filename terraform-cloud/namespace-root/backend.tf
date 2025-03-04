terraform {
  cloud {
    #organization = "nhsy-hcp-org"
    organization = "amora-hc"
    workspaces {
      name    = "terraform-vault-onboarding-baseline-configuration"
      project = "demo"
    }
  }
}