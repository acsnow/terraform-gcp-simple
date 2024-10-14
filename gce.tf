resource "google_compute_instance" "default" {
    count = var.node_count
    name = "${var.prefix}-${count.index}"
    machine_type = "n1-standard-1"
 
    boot_disk {
         initialize_params {
             #image =  data.google_compute_image.ubuntu_image.self_link
             #image = "rhel-8-v20230509"
             #image =  "ubuntu-2004-focal-v20240830"
             image =  "ubuntu-pro-1604-xenial-v20240924"
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
}
