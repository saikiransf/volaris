terraform { 
  cloud { 
    
    organization = "saikiran1438" 

    workspaces { 
      name = "Volaris-tf" 
    } 
  } 
}

terraform {
  required_providers {
    okta = {
      source = "okta/okta"
      version = "~> 6.6.1"
    }
  }
}

provider "okta" {
  # Configuration options
  org_name  = var.org_name
  base_url  = var.base_url
  client_id = var.client_id

  scopes = toset([
    "okta.apps.read", "okta.apps.manage",
    "okta.appGrants.read", "okta.appGrants.manage",
    "okta.authenticators.read", "okta.authenticators.manage",
    "okta.features.read", "okta.features.manage",
    "okta.groups.read", "okta.groups.manage",
    "okta.policies.read", "okta.policies.manage",
    "okta.roles.read", "okta.roles.manage",
    "okta.schemas.read", "okta.schemas.manage",
    "okta.threatInsights.read", "okta.threatInsights.manage"
  ])

  private_key = var.private_key
}
