terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "6.6.0"
    }
  }
}

resource "okta_app_signon_policy" "app_signon_policies" {
  for_each = var.app_signon_policy_data

  name        = each.value.name
  description = each.value.description
  catch_all   = lookup(each.value, "catch_all", false)
}
