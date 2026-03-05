#output "public_ip" {
output "instance_name_output" {
   value = google_compute_instance.default.name
   #value = google_compute_instance.default.*.network_interface.0.access_config.0.nat_ip
}
