

resource "google_container_cluster" "demo_wiz_01" {
  name     = "demo-wiz-01"
  location = "${var.region}"
  deletion_protection = false
  remove_default_node_pool = false

  # We can define additional properties such as node pools, networking, etc.
  initial_node_count = 1
  node_config {
    machine_type = "n2-standard-2"

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

