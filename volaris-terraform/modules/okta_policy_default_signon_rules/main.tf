terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "6.6.0"
    }
  }
}

## Retrieve the default signon policy Id
data "okta_default_policy" "default_signon" {
  type = "OKTA_SIGN_ON"
}

## Process the default signon policy rules
resource "okta_policy_rule_signon" "default_anywhere_rules" {
    policy_id = data.okta_default_policy.default_signon.id

    name = "CatchAll"
    access = "DENY"
}