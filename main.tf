provider "google" {
  project      = "tfc-sip-01"
  region       = "us-west1"
  zone 	       = "us-west1-a"
}

#ubuntu-2204-jammy-v20240228  ubuntu-2204-lts
data "google_compute_image" "ubuntu_image" {
  family  = "ubuntu-2310-amd64"
#  project = "tfc-sip-01"
}

variable "prefix" {
  default = "csnow"
}

resource "google_compute_instance" "default" {
    count = 1
    name = "${var.prefix}-${count.index}"
    machine_type = "n1-standard-1"
 
    boot_disk {
         initialize_params {
             image =  data.google_compute_image.ubuntu_image.self_link
             #image =  "ubuntu-2004-focal-v20210323"
         }
    }

    #metadata = {
    #    ssh-keys = "csnow:${file("~/.ssh/id_rsa.pub")}"
    #}


    network_interface {
        network = "primary-vault-vpc"
	subnetwork = "primary-subnet-01"
        access_config {
            # nat_ip is here
        }
    }

    #depends_on = ["google_compute_firewall.default"]
}

output "public_ip" {
   value = google_compute_instance.default.*.network_interface.0.access_config.0.nat_ip
}

#resource "google_compute_firewall" "default" {
#    name = "csnow-test-firewall"
#    network = "default"
#    
#    allow {
#        protocol = "tcp"
#    }
#}

