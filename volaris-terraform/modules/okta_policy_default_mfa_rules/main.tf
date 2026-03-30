terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "6.6.0"
    }
  }
}

data "okta_default_policy" "default_mfa" {
  type = "MFA_ENROLL"
}

resource "okta_policy_rule_mfa" "default_rule" {
  policy_id = data.okta_default_policy.default_mfa.id

  name   = "Default MFA Enroll"
  status = "INACTIVE"
  enroll = "NEVER_INCLUDING_RECOVERY"
}
