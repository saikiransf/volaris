terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "6.6.0"
    }
  }
}

resource "okta_app_oauth" "org2org_oauth_app" {
  label          = "Org2Org Authentication Application"
  type           = "web"
  response_types = ["code"]
  grant_types    = ["authorization_code"]
  redirect_uris  = ["https://example.com/"]
}
