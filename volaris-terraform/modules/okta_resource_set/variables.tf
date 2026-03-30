variable "org_url" {
  description = "The full Okta tenant org URL."
  type        = string
}

variable "resource_set_data" {
  description = "The custom resource set data."
  type        = map(any)
}
