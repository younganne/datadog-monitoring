terraform {

  required_providers {
    datadog = {
      source  = "DataDog/datadog"
      version = "3.46.0"
    }
  }

  required_version = "~> 1"
}

# Configure the Datadog provider
provider "datadog" {
  api_key  = var.datadog_api_key
  app_key  = var.datadog_app_key
  api_url  = var.datadog_app_url
  validate = false
}
