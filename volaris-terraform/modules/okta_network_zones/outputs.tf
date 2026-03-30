output "network_zones" {
  value = merge(okta_network_zone.ip_zones, okta_network_zone.dynamic_zones)
}
