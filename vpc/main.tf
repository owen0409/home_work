provider "google-beta" {
}

terraform {
  backend "gcs" {}
}

resource "google_compute_network" "vpc_network" {
  project                 = var.project_id
  name                    = var.vpc_network_name
  auto_create_subnetworks = false
  mtu                     = 1460
}


resource "google_compute_subnetwork" "default" {
  project                 = var.project_id
  name          = "test-subnet"
  ip_cidr_range = "10.1.1.0/24"
  region        = "asia-east2"
  network       = google_compute_network.vpc_network.id
}


resource "google_compute_firewall" "default" {
  project                 = var.project_id
  name    = "test-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22","80"]
  }

  source_ranges = ["0.0.0.0/0"]
}
