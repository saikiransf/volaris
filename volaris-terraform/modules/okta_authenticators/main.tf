terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "6.6.0"
    }
  }
}

resource "okta_authenticator" "authenticators" {
  for_each = var.authenticator_data

  name = each.value.name
  key  = each.value.key
  status = each.value.status
}
