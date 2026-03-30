variable "group_ids" {
  description = "A map of group names to IDs."
  type        = map(any)
}

variable "everyone_group_id" {
  description = "The built-in 'Everyone' group Id from the Okta tenant."
  type        = string
}

variable "mfa_policy_data" {
  description = "The MFA enrollment policy data."
  type        = map(any)
}
