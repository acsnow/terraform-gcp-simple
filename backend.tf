terraform {
  backend "remote" {
    organization = "ignw"

    workspaces {
      name = "terraform-gcp-simple"
    }
  }
}
