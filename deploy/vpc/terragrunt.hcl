terraform {
  source = "../../../vpc"
}

include {
  path = find_in_parent_folders()
}

inputs = {
project_id = "organic-cat-322902"
vpc_network_name = "test-vpc"
}
