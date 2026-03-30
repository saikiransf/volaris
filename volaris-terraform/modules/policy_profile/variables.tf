variable "profile" {
  description = "The selected profile (bronze, silver, gold) for this Okta tenant."
  type        = string
}

variable "vbuid" {
  description = "The VBUID for the Okta tenant (usually the subdomain)."
  type        = string
}

variable "o365_tenant_name" {
  description = "The Office 365 tenant name (i.e., acme.microsoft.com -> acme)."
  type        = string
}

variable "api_service_issuer" {
  description = "The Okta domain for the VBU tenant."
  type        = string
}

variable "jwks_uri" {
  description = "The JWKS URI for private_key_jwt API Service application."
  type        = string
}
