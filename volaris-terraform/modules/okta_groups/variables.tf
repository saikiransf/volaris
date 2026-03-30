variable "group_data" {
  description = "The group data to create."
  type        = map(any)
}

variable "vbuid" {
  description = "The VBUID for the Okta tenant (usually the subdomain)."
  type        = string
}
