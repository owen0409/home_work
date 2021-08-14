terraform {
  source = "../../../VM"
}

include {
  path = find_in_parent_folders()
}

inputs = {
project_id = "organic-cat-322902"
image-test = "image-centos7"
image-project = "organic-cat-322902"
machine-type = "e2-standard-2"
host-name = "test-vm-1"
zone = "asia-east2-a"
vm-tag = ["test-vm"]
boot-disk-size = 100
boot-disk-type = "pd-standard"
subnet = "https://www.googleapis.com/compute/v1/projects/organic-cat-322902/regions/asia-east2/subnetworks/test-subnet"
network-ip = "10.1.1.2"
}
