variable "mfa_policy_ids" {
  description = "The MFA enrollment policies created by the MFA enrollment module."
  type        = map(any)
}

variable "mfa_policy_rule_data" {
  description = "The MFA Enrollment policy rules data."
  type        = map(any)
}
