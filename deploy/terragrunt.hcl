remote_state {
 backend = "gcs"
 config  = {
  bucket = "terraform-state-001"
  prefix = "${path_relative_to_include()}/"
 }
}

inputs = {
 project_id         = "organic-cat-322902"
}
