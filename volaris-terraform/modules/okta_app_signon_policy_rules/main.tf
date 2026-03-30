terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "6.6.0"
    }
  }
}

resource "okta_app_signon_policy_rule" "app_signon_rules" {
  for_each = var.app_signon_policy_rule_data

  policy_id            = var.app_signon_policy_ids[each.value.policy_id].id
  name                 = each.value.name
  priority             = each.value.priority
  factor_mode          = each.value.factor_mode
  groups_included      = [for grp in each.value.groups_included : var.group_ids[grp].id]
  device_is_registered = lookup(each.value, "device_is_registered", null)
  device_is_managed    = lookup(each.value, "device_is_managed", null)

  dynamic "platform_include" {
    for_each = each.value.platform_include

    content {
      os_type = platform_include.value.os_type
      type    = platform_include.value.type
    }
  }

  constraints = length(each.value.constraints) == 0 ? null : [jsonencode(each.value.constraints[0])]
}

# DISABLED - Doesn't work with Dynamic block for "rule"
# resource "okta_app_signon_policy_rules" "app_signon_rules" {
#   for_each = var.app_signon_policy_rule_data

#   policy_id = var.app_signon_policy_ids[each.key].id

#   dynamic "rule" {
#     for_each = each.value

#     name                 = rule.value.name
#     priority             = rule.value.priority
#     status               = rule.value.status
#     groups_included      = [for grp in rule.value.groups_included : var.group_ids[grp].id]
#     device_is_registered = lookup(rule.value, "device_is_registered", null)
#     device_is_managed    = lookup(rule.value, "device_is_managed", null)

#     dynamic "platform_include" {
#       for_each = rule.value.platform_include

#       content {
#         os_type = platform_include.value.os_type
#         type    = platform_include.value.type
#       }
#     }
#   }
# }
