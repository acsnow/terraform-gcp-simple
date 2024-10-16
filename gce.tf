data "google_compute_image" "ubuntu" {
#  family  = "ubuntu-1804-mongodb"
  name = "ubuntu-1804-mongodb-wiz"
  project = "admin-services-279721"
}


resource "google_compute_instance" "default" {
    count = var.node_count
    name = "${var.prefix}-${count.index}"
    machine_type = "n1-standard-1"
 
    boot_disk {
         initialize_params {
             image = data.google_compute_image.ubuntu.self_link 
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
    service_account {
        # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
        email  = "tf-provisioner-dev@admin-services-279721.iam.gserviceaccount.com"
        scopes = ["cloud-platform"]
    }
}
