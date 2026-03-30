terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "6.6.0"
    }
  }
}

resource "okta_app_oauth_role_assignment" "app_role_assignments" {
  client_id    = var.oauth_app_id
  type         = "CUSTOM"
  role         = var.custom_admin_roles["volaris_org2org_admin_role"].id
  resource_set = var.custom_resource_sets["volaris_org2org_admin_role"].id
}
