terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "6.6.0"
    }
  }
}

resource "okta_resource_set" "custom_resource_sets" {
  for_each = {
    for k, value in var.resource_set_data: k => value
    if lookup(value, "type", null) == "basic_resources"
  }

  label       = each.value.label
  description = each.value.description

  resources = [
    for res in each.value.resources: format(res, var.org_url)
  ]
}


# resource "okta_resource_set" "custom_resource_set" {
#   label       = "Volaris Group Org2Org Admin"
#   description = "Volaris Group Org2Org Admin"

#   resources = [
#     format("%s/api/v1/users", var.org_url),
#     format("%s/api/v1/groups", var.org_url)
#   ]
# }
