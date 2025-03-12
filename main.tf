# User Resource
# You can create a user with this given resource or you can use an existing user given that you know the id.
resource "genesyscloud_user" "sample_user" {
  email = "john@example.com"
  name  = "John Doe"

  # Optional parameters. You can comment out or remove the parameters that you don't need.
  password        = "initial-password"
  division_id     = genesyscloud_auth_division.home.id
  state           = "active"
  department      = "Development"
  title           = "Senior Director"
  manager         = genesyscloud_user.example-user-manager.id
  acd_auto_answer = true
  profile_skills  = ["Java", "Go"]
  certifications  = ["Certified Developer"]
  addresses {
    other_emails {
      address = "john@gmail.com"
      type    = "HOME"
    }
    phone_numbers {
      number     = "+13174181234"
      media_type = "PHONE"
      type       = "MOBILE"
    }
  }
  routing_skills {
    skill_id    = genesyscloud_routing_skill.test-skill.id
    proficiency = 4.5
  }
  routing_languages {
    language_id = genesyscloud_routing_language.english.id
    proficiency = 4
  }
  locations {
    location_id = genesyscloud_location.main-site.id
    notes       = "Office 201"
  }
  employer_info {
    official_name = "Jonathon Doe"
    employee_id   = "12345"
    employee_type = "Full-time"
    date_hire     = "2021-03-18"
  }
  routing_utilization {
    call {
      maximum_capacity = 1
      include_non_acd  = true
    }
    callback {
      maximum_capacity          = 2
      include_non_acd           = false
      interruptible_media_types = ["call", "email"]
    }
    chat {
      maximum_capacity          = 3
      include_non_acd           = false
      interruptible_media_types = ["call"]
    }
    email {
      maximum_capacity          = 2
      include_non_acd           = false
      interruptible_media_types = ["call", "chat"]
    }
    message {
      maximum_capacity          = 4
      include_non_acd           = false
      interruptible_media_types = ["call", "chat"]
    }
    label_utilizations {
      label_id         = genesyscloud_routing_utilization_label.red_label.id
      maximum_capacity = 4
    }
    label_utilizations {
      label_id               = genesyscloud_routing_utilization_label.blue_label.id
      maximum_capacity       = 4
      interrupting_label_ids = [genesyscloud_routing_utilization_label.red_label.id]
    }
  }
}

# Location Resource
# You can create a location with this given resource or you can use an existing location given that you know the id.
resource "genesyscloud_location" "gc_location_samplelocation" {
  name  = "GC Sample Location"
  notes = "A sample location"
  address {
    street1  = "ABC 123 Avenue"
    city     = "Menlo Park"
    state    = "CA"
    country  = "US"
    zip_code = "123456"
  }
  emergency_number {
    number = "1234567890"
    type   = "default"
  }
}

# Site Resource
# You can create a site with this given resource or you can use an existing site given that you know the id.
resource "genesyscloud_telephony_providers_edges_site" "gc_site_samplesite" {
  name        = "GC Sample Site"
  location_id = genesyscloud_location.gc_trial_location_locationname.id # or you can manually provide the id of the location
  media_model = "Cloud"

  # Optional parameters. You can comment out or remove the parameters that you don't need.
  media_regions_use_latency_based = true

  edge_auto_update_config {
    time_zone = "America/New_York"
    rrule     = "FREQ=WEEKLY;BYDAY=SU"
    start     = "2021-08-08T08:00:00.000000"
    end       = "2021-08-08T11:00:00.000000"
  }

  number_plans {
    name           = "numberList plan"
    classification = "numberList classification"
    match_type     = "numberList"
    numbers {
      start = "114"
      end   = "115"
    }
  }

  number_plans {
    name           = "digitLength plan"
    classification = "digitLength classification"
    match_type     = "digitLength"
    digit_length {
      start = "6"
      end   = "8"
    }
  }
}

# Phone Base Settings Resource
# You can create a phone base setting with this given resource or you can use an existing base setting given that you know the id.
resource "genesyscloud_telephony_providers_edges_phonebasesettings" "gc_phonebasesettings_webrtc_samplesetting" {
  name               = "GC Example WebRTC Phone Base Settings"
  description        = "GC Example WebRTC Phone Base Settings"
  phone_meta_base_id = "inin_webrtc_softphone.json"

  # Optional parameters. You can comment out or remove the parameters that you don't need.
  properties = jsonencode({
    "phone_label" = {
      "value" = {
        "instance" = "PureCloud WebRTC Phone"
      }
    },
    "phone_maxLineKeys" = {
      "value" = {
        "instance" = 1
      }
    },
    "phone_media_codecs" = {
      "value" = {
        "instance" = [
          "audio/opus"
        ]
      }
    },
    "phone_media_dscp" = {
      "value" = {
        "instance" = 46
      }
    },
    "phone_sip_dscp" = {
      "value" = {
        "instance" = 24
      }
    }
  })
  capabilities {
    registers             = false
    provisions            = false
    dual_registers        = false
    no_cloud_provisioning = false
    allow_reboot          = false
    hardware_id_type      = "mac"
    no_rebalance          = false
    media_codecs = [
      "audio/opus"
    ]
    cdm = true
  }
}

# Phone Resource
resource "genesyscloud_telephony_providers_edges_phone" "gc_webrtcphone_sampleuser" {
  name                   = "GC WebRTC Phone Example User"
  state                  = "active"
  site_id                = genesyscloud_telephony_providers_edges_site.gc_site_samplesite.id                                     # or manually provide the site ID
  web_rtc_user_id        = genesyscloud_user.sample_user.id                                                                      # or manually provide the user ID
  phone_base_settings_id = genesyscloud_telephony_providers_edges_phonebasesettings.gc_phonebasesettings_webrtc_samplesetting.id # or manually provide the phone base settings ID

  # Other optional parameters. You can comment out or remove the parameters that you don't need.
  line_base_settings_id = data.genesyscloud_telephony_providers_edges_linebasesettings.line-base-settings.id
  phone_meta_base_id    = "inin_webrtc_softphone.json"
  properties            = "{}"

  line_properties {
    line_address = ["+10123456789"]
  }

  capabilities {
    provisions            = false
    registers             = false
    dual_registers        = false
    allow_reboot          = false
    no_rebalance          = false
    no_cloud_provisioning = false
    cdm                   = true
    hardware_id_type      = "mac"
    media_codecs          = ["audio/opus"]
  }
}
