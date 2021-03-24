provider "google" {
  #credentials = "../five9/secrets/packer-image-creator.json"
  project      = "ignw-anthos-lab-pod1a"
  region       = "us-west1"
  zone 	       = "us-west1-a"
}

#data "google_compute_image" "ubuntu_image" {
#  family  = "ubuntu-2004-lts"
#  project = "ignw-anthos-lab-pod1a"
#}

variable "prefix" {
  default = "csnow"
}

resource "google_compute_instance" "default" {
    count = 2
    name = "${var.prefix}-${count.index}"
    machine_type = "n1-standard-1"
 
    boot_disk {
         initialize_params {
             #image =  data.google_compute_image.ubuntu_image.self_link
             image =  "ubuntu-2004-focal-v20210323"
         }
    }

    #metadata = {
    #    ssh-keys = "csnow:${file("~/.ssh/id_rsa.pub")}"
    #}


    network_interface {
        network = "default"
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

