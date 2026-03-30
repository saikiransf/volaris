terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "6.6.0"
    }
  }
}

resource "okta_app_swa" "o365_template_app" {
  preconfigured_app = "office365"
  label             = "Microsoft Office 365 - ${var.o365_tenant_name}"
  status            = "ACTIVE"
}

# resource "okta_app_saml" "o365_template_app" {
#   preconfigured_app = "office365"
#   label             = "Microsoft Office 365 - ${var.o365_tenant_name}"
#   status            = "ACTIVE"
#   saml_version      = "1.1"

#   app_settings_json = jsonencode({
#     "tenantType": null,
#     "wsFedConfigureType" : "AUTO",
#     "windowsTransportEnabled" : false,
#     "domain" : "dummy_domain",
#     "msftTenant" : "${var.o365_tenant_name}",
#     "domains" : [],
#     "office365ProvisioningType": null,
#     "requireAdminConsent" : false,
#     "office365FlexibleProvisioningMode": null
#   })

#   app_links_json = jsonencode({
#     "calendar" : false,
#     "crm" : false,
#     "delve" : false,
#     "excel" : false,
#     "forms" : false,
#     "mail" : false,
#     "newsfeed" : false,
#     "onedrive" : false,
#     "people" : false,
#     "planner" : false,
#     "powerbi" : false,
#     "powerpoint" : false,
#     "sites" : false,
#     "sway" : false,
#     "tasks" : false,
#     "teams" : false,
#     "video" : false,
#     "word" : false,
#     "yammer" : false,
#     "login" : true
#   })
# }
