terraform {
  backend "gcs" {
    bucket  = "csnow-orca-cse-lab-tfstate"
    prefix  = "terraform-gcp-simple-state"
  }
}
