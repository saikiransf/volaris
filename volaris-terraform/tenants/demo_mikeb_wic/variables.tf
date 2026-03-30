variable "client_id" {
  type        = string
  description = "The Terraform Services application client ID from Okta."
}

variable "org_name" {
  type        = string
  description = "The org subdomain for the Okta tenant."
}

variable "base_url" {
  type        = string
  default     = "okta.com"
  description = "The the base domain for the Okta tenant."
}

variable "private_key" {
  type        = string
  description = "The private key for the Terraform Services application."
  sensitive   = true
}

variable "o365_tenant_name" {
  description = "The O365 tenant name for the template application."
  type        = string
}

variable "jwks_uri" {
  description = "The URI to automatically retrieve the JWKS keys for the Org2Org API Service application."
  type        = string
}
