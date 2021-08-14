provider "google" {
  credentials = file("/home/owen0409/organic-cat-322902-b1faae0ead35.json")
  project     = "organic-cat-322902"
  region      = "us-west1"
}

resource "google_compute_network" "vpc_network" {
  project                 = var.project_id
  name                    = var.vpc_network_name
  auto_create_subnetworks = true
  mtu                     = 1460
}