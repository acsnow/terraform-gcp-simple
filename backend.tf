terraform {
  backend "gcs" {
    bucket  = "terraform-csnow-state"
    prefix  = "terraform-gcp-simple-state"
  }
}
