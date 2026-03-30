terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "6.6.0"
    }
  }
}

resource "okta_threat_insight_settings" "threat_insight" {
  action = "block"

  # Expand to leverage exemption network zones
  # network_excludes = []
}
