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

module "gke" {
  source = "../../modules/gke"

  cluster_name        = "gke-dev-cluster"
  zone                = "us-east1-b"
  network             = module.network.vpc_id
  subnetwork          = module.network.subnet_id
  pods_range_name     = module.network.pods_range_name
  services_range_name = module.network.services_range_name

  node_pool_name = "gke-dev-node-pool"
  node_count     = 1
  machine_type   = "e2-small"
  disk_size_gb   = 30
}
