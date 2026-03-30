terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "6.6.0"
    }
  }
}

resource "okta_network_zone" "ip_zones" {
  for_each = {
    for k, value in var.network_zone_data : k => value
    if value.type == "IP"
  }

  name = each.value.name
  type = "IP"

  gateways = each.value.gateways
  proxies  = each.value.proxies
}

resource "okta_network_zone" "dynamic_zones" {
  for_each = {
    for k, value in var.network_zone_data : k => value
    if value.type == "DYNAMIC"
  }

  name = each.value.name
  type = "DYNAMIC"

  usage              = each.value.usage
  dynamic_proxy_type = each.value.dynamic_proxy_type
  dynamic_locations  = each.value.dynamic_locations
}
