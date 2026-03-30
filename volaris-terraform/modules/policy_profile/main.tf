terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "6.6.0"
    }
  }
}

data "okta_group" "everyone" {
  name = "Everyone"
}

## Policy configuration input JSON files
locals {
  groups_data_path = abspath("${path.module}/config/${var.profile}/okta_groups_data.json")
  groups_data      = fileexists(local.groups_data_path) ? jsondecode(file(local.groups_data_path)) : {}

  user_schema_property_data_path = abspath("${path.module}/config/${var.profile}/okta_user_schema_property_data.json")
  user_schema_property_data      = fileexists(local.user_schema_property_data_path) ? jsondecode(file(local.user_schema_property_data_path)) : {}

  network_zone_data_path = abspath("${path.module}/config/${var.profile}/okta_network_zone_data.json")
  network_zone_data      = fileexists(local.network_zone_data_path) ? jsondecode(file(local.network_zone_data_path)) : {}

  signon_policy_data_path = abspath("${path.module}/config/${var.profile}/okta_signon_policy_data.json")
  signon_policy_data      = fileexists(local.signon_policy_data_path) ? jsondecode(file(local.signon_policy_data_path)) : {}

  signon_policy_rule_data_path = abspath("${path.module}/config/${var.profile}/okta_signon_policy_rule_data.json")
  signon_policy_rule_data      = fileexists(local.signon_policy_rule_data_path) ? jsondecode(file(local.signon_policy_rule_data_path)) : {}

  authenticator_data_path = abspath("${path.module}/config/${var.profile}/okta_authenticator_data.json")
  authenticator_data      = fileexists(local.authenticator_data_path) ? jsondecode(file(local.authenticator_data_path)) : {}

  mfa_policy_data_path = abspath("${path.module}/config/${var.profile}/okta_mfa_policy_data.json")
  mfa_policy_data      = fileexists(local.mfa_policy_data_path) ? jsondecode(file(local.mfa_policy_data_path)) : {}

  mfa_policy_rule_data_path = abspath("${path.module}/config/${var.profile}/okta_mfa_policy_rule_data.json")
  mfa_policy_rule_data      = fileexists(local.mfa_policy_rule_data_path) ? jsondecode(file(local.mfa_policy_rule_data_path)) : {}

  app_signon_policy_data_path = abspath("${path.module}/config/${var.profile}/okta_app_signon_policy_data.json")
  app_signon_policy_data      = fileexists(local.app_signon_policy_data_path) ? jsondecode(file(local.app_signon_policy_data_path)) : {}

  app_signon_policy_rule_data_path = abspath("${path.module}/config/${var.profile}/okta_app_signon_policy_rule_data.json")
  app_signon_policy_rule_data      = fileexists(local.app_signon_policy_rule_data_path) ? jsondecode(file(local.app_signon_policy_rule_data_path)) : {}

  admin_role_custom_data_path = abspath("${path.module}/config/${var.profile}/okta_admin_role_custom_data.json")
  admin_role_custom_data      = fileexists(local.admin_role_custom_data_path) ? jsondecode(file(local.admin_role_custom_data_path)) : {}

  resource_set_data_path = abspath("${path.module}/config/${var.profile}/okta_resource_set_data.json")
  resource_set_data      = fileexists(local.resource_set_data_path) ? jsondecode(file(local.resource_set_data_path)) : {}

  feature_flag_data_path = abspath("${path.module}/config/${var.profile}/okta_features_data.json")
  feature_flag_data      = fileexists(local.feature_flag_data_path) ? jsondecode(file(local.feature_flag_data_path)) : {}
}

module "okta_groups" {
  source = "../okta_groups"

  group_data = local.groups_data
  vbuid      = var.vbuid
}

module "okta_user_schema_property" {
  source = "../okta_user_schema_property"

  user_schema_property_data = local.user_schema_property_data
}

module "okta_network_zones" {
  source = "../okta_network_zones"

  network_zone_data = local.network_zone_data
}

module "okta_policy_signon" {
  depends_on = [module.okta_groups]
  source     = "../okta_policy_signon"

  signon_policy_data = local.signon_policy_data
  group_ids          = module.okta_groups.group_ids
  everyone_group_id  = data.okta_group.everyone.id
  vbuid              = var.vbuid
}

module "okta_policy_signon_rules" {
  source = "../okta_policy_signon_rules"

  signon_policy_rule_data = local.signon_policy_rule_data
  signon_policy_ids       = module.okta_policy_signon.signon_policies

  # Can be provided if specific networks are available/managed
  network_zone_ids = {}
}

module "okta_policy_default_signon_rules" {
  source = "../okta_policy_default_signon_rules"
}

module "okta_authenticators" {
  source = "../okta_authenticators"

  authenticator_data = local.authenticator_data
}

module "okta_policy_mfa" {
  source = "../okta_policy_mfa"

  mfa_policy_data   = local.mfa_policy_data
  group_ids         = module.okta_groups.group_ids
  everyone_group_id = data.okta_group.everyone.id
}

module "okta_policy_mfa_rules" {
  source = "../okta_policy_mfa_rules"

  mfa_policy_rule_data = local.mfa_policy_rule_data
  mfa_policy_ids       = module.okta_policy_mfa.mfa_policies
}

module "okta_policy_default_mfa_rules" {
  source = "../okta_policy_default_mfa_rules"
}

module "okta_app_signon_policy" {
  source = "../okta_app_signon_policy"

  app_signon_policy_data = local.app_signon_policy_data
}

module "okta_app_signon_policy_rules" {
  source = "../okta_app_signon_policy_rules"

  group_ids                   = module.okta_groups.group_ids
  app_signon_policy_ids       = module.okta_app_signon_policy.app_signon_policy_ids
  app_signon_policy_rule_data = local.app_signon_policy_rule_data
}

module "okta_admin_role_custom" {
  source = "../okta_admin_role_custom"

  admin_role_custom_data = local.admin_role_custom_data
}

module "okta_resource_set" {
  source = "../okta_resource_set"

  org_url           = var.api_service_issuer
  resource_set_data = local.resource_set_data
}

# module "okta_m365_template_app" {
#   source = "../okta_m365_template_app"

#   o365_tenant_name = var.o365_tenant_name
# }

module "okta_org2org_oauth_app" {
  source = "../okta_org2org_oauth_app"
}

module "okta_org2org_api_service_app" {
  source = "../okta_org2org_api_service_app"

  api_service_issuer = var.api_service_issuer
  jwks_uri           = var.jwks_uri
}

module "okta_app_oauth_role_assignment" {
  source = "../okta_app_oauth_role_assignment"

  oauth_app_id         = module.okta_org2org_api_service_app.api_service_app_id
  custom_resource_sets = module.okta_resource_set.custom_resource_sets
  custom_admin_roles   = module.okta_admin_role_custom.custom_admin_roles
}

module "okta_threat_insight_settings" {
  source = "../okta_threat_insight_settings"
}

module "okta_feature_flags" {
  source = "../okta_feature_flags"

  feature_flag_data = local.feature_flag_data
}

module "okta_app_bookmark" {
  source = "../okta_app_bookmark"
}
