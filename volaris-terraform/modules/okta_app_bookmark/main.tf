terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "6.6.0"
    }
  }
}

resource "okta_app_bookmark" "hub_access_requests" {
  label  = "Volaris Global Requests App"
  url    = "https://volarisgroup.okta.com/enduser/resource/catalog/list"
  status = "ACTIVE"
}
