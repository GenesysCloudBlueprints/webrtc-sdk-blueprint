terraform {
  required_providers {
    genesyscloud = {
      source  = "mypurecloud/genesyscloud"
      version = "~> 1.59.1" # You may update this to the latest version as needed
    }
  }
}

provider "genesyscloud" {
  oauthclient_id     = "Enter your OAuth Client ID here"
  oauthclient_secret = "Enter your OAuth Client Secret here"
  aws_region         = "Enter your preferred Genesys Cloud region here"
}
