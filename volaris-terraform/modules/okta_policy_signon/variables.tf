variable "group_ids" {
  description = "A map of group names to IDs."
  type        = map(any)
}

variable "everyone_group_id" {
  description = "The built-in 'Everyone' group Id from the Okta tenant."
  type        = string
}

variable "signon_policy_data" {
  description = "The Global Session Sign-On policy data."
  type        = map(any)
}

variable "vbuid" {
  description = "The VBUID for the Okta tenant (usually the subdomain)."
  type        = string
}
