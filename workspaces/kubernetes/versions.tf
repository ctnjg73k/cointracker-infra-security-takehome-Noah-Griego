terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.19.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 6.19.0"
    }
  }
  required_version = ">= 1.13.1"
}
