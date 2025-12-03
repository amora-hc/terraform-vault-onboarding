## Used for deleting resources ##
terraform {
  cloud {
    organization = "amora-hc"
    workspaces {
      name    = "terraform-vault-onboarding-namespace-vending"
      project = "vault-onboarding"
    }
  }
}