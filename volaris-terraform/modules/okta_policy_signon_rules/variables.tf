variable "signon_policy_rule_data" {
  description = "The sign-on policy rule data."
  type        = map(any)
}

variable "signon_policy_ids" {
  description = "The sign-on policies created from the Sign-On Policies module."
  type        = map(any)
}

variable "network_zone_ids" {
  description = "The network zones created from the network zones module."
  type        = map(any)
}
