terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "6.6.0"
    }
  }
}

data "okta_features" "features" {
  for_each = {
    for k, value in var.feature_flag_data : k => value
    if value.status == "ENABLE"
  }

  label = each.key
}

resource "okta_feature" "features" {
  for_each = {
    for k, value in data.okta_features.features : k => value
    if lookup(value, "features", null) != null
  }

  # The actual ID is nested in a "features" sub-object
  feature_id = each.value.features[0].id
  life_cycle = "ENABLE"
}
