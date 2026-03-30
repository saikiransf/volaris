variable "api_service_issuer" {
  description = "The Okta domain for the VBU tenant."
  type        = string
}

variable "jwks_uri" {
  description = "The JWKS URI for private_key_jwt API Service application."
  type        = string
}
