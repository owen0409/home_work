provider "google-beta" {
}

data "google_compute_image" "image" {
  family = var.image-test
  project = var.image-project
}

resource "google_compute_instance" "test-host" {
  project = var.project_id
  machine_type = var.machine-type
  name = var.host-name
  zone = var.zone

  boot_disk {
    initialize_params {
      image = data.google_compute_image.image.id
      size = var.boot-disk-size
      type = var.boot-disk-type
    }
  }

  network_interface {
    subnetwork = var.subnet
    network_ip = var.network-ip
  }

  metadata = {
    VmDnsSetting = "GlobalOnly"
  }


  lifecycle {
    ignore_changes = [attached_disk]
  }
}

resource "google_compute_disk" "test-disk" {
  project = var.project_id
  name = var.disk-name
  type = var.disk-type
  size = var.disk-size
  zone = var.zone
  physical_block_size_bytes = 4096
}

resource "google_compute_attached_disk" "default" {
  project = var.project_id
  disk = google_compute_disk.test-disk.id
  instance = google_compute_instance.test-host.id
}