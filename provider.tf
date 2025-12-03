provider "google" {
  project      = "${var.project}"
  region       = "${var.region}"
  zone 	       = "${var.zone}"
  credentials  = "/Users/csnow/git/terraform-gcp-simple/csnow-admin-services-740877b5c705.json"
}
