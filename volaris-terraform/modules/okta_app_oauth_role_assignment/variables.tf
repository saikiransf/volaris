variable "oauth_app_id" {
  description = "The OAuth API Service application ID to assign the role/resource set to."
  type        = string
}

variable "custom_resource_sets" {
  description = "The custom resource set ID to assign to the application."
  type        = map(any)
}

variable "custom_admin_roles" {
  description = "The custom admin roles to assign to the application."
  type        = map(any)
}
