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

  # Optional parameters that you can configure. You can comment out or remove the parameters that you don't need.

  aws_region   = "Enter your preferred region here"
  access_token = "If you want to use this instead of the OAuth client ID and secret"

  # Gateway Settings
  gateway {
    host     = "gateway.yourhostname.com"
    port     = "443"
    protocol = "https"
    auth {
      username = "Enter your username here"
      password = "Enter your password here"
    }

    path_params {
      path_name  = "Enter your path name here"
      path_value = "Enter your path value here"
    }
  }

  # Proxy Settings
  proxy {
    host     = "proxy.yourhostname.com"
    port     = "443"
    protocol = "https"
    auth {
      username = "Enter your username here"
      password = "Enter your password here"
    }
  }

  # SDK Debug Settings
  sdk_debug           = false
  sdk_debug_file_path = "Enter your debug file path here"
  sdk_debug_format    = "Enter your debug format here"

  # Token Pool Settings
  token_pool_size = 12345
}
