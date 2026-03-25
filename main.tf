provider "google" {
  project      = "${var.project}"
  region       = "us-west1"
  zone 	       = "us-west1-a"
}


resource "google_compute_instance" "default" {
    count = var.node_count
    name = "${var.prefix}-${count.index}"
    machine_type = "e2-micro"
    #machine_type = "e2-small"
    allow_stopping_for_update = true

    boot_disk {
         initialize_params {
             #image =  data.google_compute_image.ubuntu_image.self_link
             image = "rhel-8-v20230509"
             #image =  "ubuntu-2310-mantic-amd64-v20240305"
             #image =  "ubuntu-2204-jammy-v20260226"
         }
    }

    #can_ip_forward = true

    network_interface {
        network = "${var.vpc}"
	        subnetwork = "${var.subnet}"
        access_config {
            # nat_ip is here
        }
    }

    #depends_on = ["google_compute_firewall.default"]
}

resource "google_storage_bucket" "scan_test_bucket" {
  name          = "${var.bucket_name}"
  location      = "US" # Multi-region US, or use a specific region like "US-CENTRAL1"
  force_destroy = true  # Allows Terraform to delete the bucket even if it contains objects

  # Optional: standard security and lifecycle settings
  public_access_prevention = "enforced"
  
  versioning {
    enabled = true
  }

  uniform_bucket_level_access = true
}


resource "google_container_cluster" "demo_orca_01" {
  name     = "${var.prefix}-gke-01"
  location = "us-west1-a"
  deletion_protection = false
  remove_default_node_pool = false

  # We can define additional properties such as node pools, networking, etc.
  initial_node_count = 1
  node_config {
    machine_type = "e2-small"

    # Configure the OAuth scopes to allow the nodes to access Google Cloud services
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  network = "${var.vpc}"
  subnetwork = "${var.subnet}"

  # Enable some addons for the cluster
  addons_config {
    http_load_balancing        { disabled = false }
    horizontal_pod_autoscaling { disabled = false }
  }
}
