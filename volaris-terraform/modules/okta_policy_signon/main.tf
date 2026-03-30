terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "6.6.0"
    }
  }
}

resource "okta_policy_signon" "signon_policies" {
  for_each = var.signon_policy_data

  priority    = each.value.priority
  status      = each.value.status
  name        = each.value.name
  description = each.value.description

  groups_included = [for grp in each.value.groups_included : try(var.group_ids[grp].id, var.everyone_group_id)]
}