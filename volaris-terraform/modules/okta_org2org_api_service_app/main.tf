terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "6.6.0"
    }
  }
}

resource "okta_app_oauth" "org2org_api_service_app" {
  label                      = "Org2Org API Service application"
  type                       = "service"
  response_types             = ["token"]
  grant_types                = ["client_credentials"]
  token_endpoint_auth_method = "private_key_jwt"

  jwks_uri = var.jwks_uri
}

resource "okta_app_oauth_api_scope" "org2org_api_service_app_scopes" {
  app_id = okta_app_oauth.org2org_api_service_app.id

  issuer = var.api_service_issuer
  scopes = ["okta.users.read", "okta.users.manage", "okta.groups.read", "okta.groups.manage"]
}
