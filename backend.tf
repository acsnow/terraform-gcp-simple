terraform {
  backend "gcs" {
    bucket  = "csnow-test-orca-statefile"
    prefix  = "terraform-gcp-simple-state"
  }
}
