provider "google" {
  project      = "${var.project}"
  region       = "us-west1"
  zone 	       = "us-west1-a"
}

#data "google_compute_image" "ubuntu_image" {
#  family  = "ubuntu-2310-amd64"
#  project = "tfc-sip-01"
#}

resource "google_compute_instance" "default" {
    count = var.node_count
    name = "${var.prefix}-${count.index}"
    machine_type = "n1-standard-1"
 
    boot_disk {
         initialize_params {
             #image =  data.google_compute_image.ubuntu_image.self_link
             image =  "ubuntu-2310-mantic-amd64-v20240305"
         }
    }

    #metadata = {
    #    ssh-keys = "csnow:${file("~/.ssh/id_rsa.pub")}"
    #}

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

#output "public_ip" {
#   value = google_compute_instance.default.*.network_interface.0.access_config.0.nat_ip
#}

#resource "google_compute_firewall" "default" {
#    name = "csnow-test-firewall"
#    network = "default"
#    
#    allow {
#        protocol = "tcp"
#    }
#}

