terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "6.6.0"
    }
  }
}

resource "okta_policy_rule_signon" "anywhere_rules" {
  for_each = {
    for k, rule in var.signon_policy_rule_data :
    k => rule if rule.network_connection == "ANYWHERE" && lookup(var.signon_policy_ids, rule.policy_id, null) != null
  }

  policy_id = var.signon_policy_ids[each.value.policy_id].id

  priority = each.value.priority
  status   = each.value.status
  name     = each.value.name

  session_idle     = each.value.session_idle
  session_lifetime = each.value.session_lifetime

  network_connection = "ANYWHERE"
}
