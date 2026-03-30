terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "6.6.0"
    }
  }
}

resource "okta_policy_mfa" "mfa_policies" {
  for_each = var.mfa_policy_data

  name        = each.value.name
  description = each.value.description
  priority    = each.value.priority
  status      = each.value.status
  is_oie      = true

  okta_verify = {
    enroll = lookup(each.value.authenticators, "okta_verify", "NOT_ALLOWED")
  }
  okta_password = {
    enroll = lookup(each.value.authenticators, "okta_password", "NOT_ALLOWED")
  }
  webauthn = {
    enroll = lookup(each.value.authenticators, "webauthn", "NOT_ALLOWED")
  }

  groups_included = [for grp in each.value.groups_included : try(var.group_ids[grp].id, var.everyone_group_id)]
}
