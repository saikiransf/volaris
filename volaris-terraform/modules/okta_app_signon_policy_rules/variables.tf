variable "group_ids" {
  description = "A map of group names to IDs."
  type        = map(any)
}

variable "app_signon_policy_rule_data" {
  description = "The application signon policy rule data."
  type        = map(any)
}

variable "app_signon_policy_ids" {
  description = "The application signon policies created from the App SignOn policy module."
  type        = map(any)
}
