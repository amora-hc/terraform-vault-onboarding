#terraform {
#  cloud {
#    organization = "nhsy-hcp-org"
#    workspaces {
#      name    = "terraform-vault-onboarding-baseline-configuration"
#      project = "demo"
#    }
#  }
#}

terraform {
  cloud {
    organization = "amora-hc"
    workspaces {
      name    = "terraform-vault-onboarding-baseline-configuration"
      project = "vault-onboarding"
    }
  }
}