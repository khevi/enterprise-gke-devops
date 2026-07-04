terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "network" {
  source = "../../modules/network"

  vpc_name            = "gke-dev-vpc"
  subnet_name         = "gke-dev-subnet"
  subnet_cidr         = "10.10.0.0/20"
  region              = var.region
  pods_range_name     = "gke-pods-range"
  pods_cidr           = "10.20.0.0/16"
  services_range_name = "gke-services-range"
  services_cidr       = "10.30.0.0/20"
}
