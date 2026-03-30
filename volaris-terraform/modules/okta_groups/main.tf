terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "6.6.0"
    }
  }
}

resource "okta_group" "groups" {
  for_each = var.group_data

  name        = each.value.vbuid_prefixed ? join("-", [var.vbuid, each.value.name]) : each.value.name
  description = each.value.description
}
