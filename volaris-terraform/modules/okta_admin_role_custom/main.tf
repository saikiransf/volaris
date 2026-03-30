terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "6.6.0"
    }
  }
}

resource "okta_admin_role_custom" "custom_roles" {
  for_each = var.admin_role_custom_data

  label       = each.value.label
  description = each.value.description
  permissions = each.value.permissions
}
