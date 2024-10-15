data "google_compute_image" "ubuntu" {
  family  = "ubuntu-1804-mongodb"
  project = "admin-services-279721"
}


resource "google_compute_instance" "default" {
    count = var.node_count
    name = "${var.prefix}-${count.index}"
    machine_type = "n1-standard-1"
 
    boot_disk {
         initialize_params {
             #image =  "ubuntu-2004-focal-v20240830"
             #image =  "ubuntu-pro-1804-bionic-v20240924"
             #image =  "ubuntu-pro-1604-xenial-v20240924"
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
        email  = "1051112938655-compute@developer.gserviceaccount.com"
        scopes = ["cloud-platform"]
    }
}
