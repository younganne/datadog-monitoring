
import {
  to = datadog_synthetics_test.site_liveness
  id = "<test_id>"
}

resource "datadog_synthetics_test" "site_liveness" {
  name    = "Liveness test on https://www.example.com"
  type    = "browser"
  subtype = "http"
  status  = "live"
  tags = [
    "check_status:live",
    "check_type:browser",
    "ci_execution_rule:blocking",
    "probe_dc:aws:ap-southeast-2",
    "probe_dc:azure:eastus",
    "probe_dc:gcp:europe-west3",
    "team:it"
  ]
  locations = [
    "aws:us-west-2",   # Oregon
    "gcp:europe-west3" # Frankfurt
  ]

  device_ids = [
    "chrome.laptop_large"
  ]

  request_definition {
    method = "GET"
    url    = "https://www.example.com"
  }

  browser_step {
    name = "Click on link \"About Us\""
    type = "click"
    params {
      click_type = "primary"
      element_user_locator {
        value {
          value = "//a[@href and text() = 'About Us']"
          type  = "xpath"
        }
      }
    }
  }

  browser_step {
    name = "Click on link \"People\""
    type = "click"
    params {
      click_type = "primary"
      element_user_locator {
        value {
          value = "//a[@href and text() = 'People']"
          type  = "xpath"
        }
      }
    }
  }

  browser_step {
    name = "Click on link \"Publications\""
    type = "click"
    params {
      click_type = "primary"
      element_user_locator {
        value {
          value = "//a[@href and text() = 'Publications']"
          type  = "xpath"
        }
      }
    }
  }

  options_list {
    tick_every           = 3600 # run every 1 hour
    min_failure_duration = 120  # alert after 2 minutes
    retry {
      count    = 10    # run up to 10 times to trigger the monitoring alerts
      interval = 60000 # wait 60 seconds after failure to retry
    }
  }
}

resource "datadog_monitor" "site_downtime" {
  name                = "Name for monitor foo"
  require_full_window = false
  type                = "error-tracking alert"
  message             = <<-EOT
    www.example.com is down!
    {{#is_alert}}
    Down for >= 10 minutes!
    Notifying @sns-Config-Notifications @sns-GuardDuty-NetworkFirewall-AutoBlock-GuardDutyToFirewallSNSTopic-IgXQHUVrFIJS
    {{/is_alert}}

    {{#is_warning}}
    Down for >= 3 minutes.
    Notifying @user@example.com, @slack-it-alerts
    {{/is_warning}}
    EOT

  query = "error-tracking-rum(\"@synthetics.test_id:<test_id>\").rollup(\"count\").by(\"issue.id\").last(\"1hr\") > 10"

  monitor_thresholds {
    warning  = 3
    critical = 10
  }
}
