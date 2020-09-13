variable "gcp_vpc_name"{}

variable "subnet_gcp_name"{}
variable "subnet_ip_cidr_range"{}

variable "gcp_subnet_region"{}

variable "gcp_compute_firewall"{}

variable "allowed_ports"{}

variable "gcp_project_id"{}


// Creating a VPC
resource "google_compute_network" "vpc_gcp" {
 name =  var.gcp_vpc_name
 auto_create_subnetworks=false
  project= var.gcp_project_id
}
// Creating a subnetwork
resource "google_compute_subnetwork" "subnet_vpc" {
    depends_on=[google_compute_network.vpc_gcp]
    name          =var.subnet_gcp_name
 ip_cidr_range = var.subnet_ip_cidr_range
 region        =var.gcp_subnet_region
 network       = google_compute_network.vpc_gcp.id
}
// Creating a firewall
resource "google_compute_firewall" "default" {
depends_on=[google_compute_network.vpc_gcp]
 name    =var.gcp_compute_firewall
 network = google_compute_network.vpc_gcp.name
 allow {
        protocol = "icmp"
 }
 allow {
        protocol = "tcp"
        ports    = var.allowed_ports
 }
}