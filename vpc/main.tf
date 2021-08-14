provider "google-beta" {
  version = "~> 2.14.0"
}

resource "google_compute_network" "vpc_network" {
  project                 = var.project_id
  name                    = var.vpc_network_name
  auto_create_subnetworks = true
  mtu                     = 1460
}