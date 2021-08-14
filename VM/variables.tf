variable "project_id" {
  type = string
  default = "organic-cat-322902"
}

variable "image-test" {
  type = string
  default = "gce-uefi-images"
}

variable "image-project" {
  type = string
  default = "centos-7"
}

variable "machine-type" {
  type = string
  default = "e2-standard-2"
}
variable "host-name" {
  type = string
  default = "test_vm_1"
}
variable "zone" {
  type = string
  default = "asia-east2-a"
}
variable "boot-disk-size" {
  type = number
  default = 100
}
variable "boot-disk-type" {
  type = string
  default = "pd-standard"
}
variable "subnet" {
  type = string
  default = "https://www.googleapis.com/compute/v1/projects/organic-cat-322902/regions/asia-east2/subnetworks/test-subnet"
}
variable "network-ip" {
  type = string
  default = "10.1.1.2"
}
variable "disk-name" {
  type = string
  default = test_vm_1
}
variable "disk-type" {
  type = string
  default = "pd-standard"
}
variable "disk-size" {
  type = number
  default = 100
}
