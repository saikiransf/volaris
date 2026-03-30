terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "6.6.0"
    }
  }
}

resource "okta_policy_rule_mfa" "mfa_policy_rules" {
  for_each = var.mfa_policy_rule_data

  policy_id = var.mfa_policy_ids[each.value.policy_id].id
  name      = each.value.name
  priority  = each.value.priority
  status    = each.value.status
}
