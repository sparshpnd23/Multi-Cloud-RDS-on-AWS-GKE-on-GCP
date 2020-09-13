variable "google_container_cluster_name"{}

variable "google_container_cluster_location"{}

variable "gcp_node_config_machine_type"{}




resource "google_container_cluster" "gcp_cluster" {
depends_on=[google_compute_network.vpc_gcp]
 name               = var.google_container_cluster_name
 location           = var.google_container_cluster_location
 initial_node_count = 1
 master_auth {
        username = ""
        password = ""
        client_certificate_config {
            issue_client_certificate = false
        }
    }
    node_config {
        machine_type= "n1-standard-1"
    }
    network= google_compute_network.vpc_gcp.name
    project=var.gcp_project_id
    subnetwork=google_compute_subnetwork.subnet_vpc.name
}
// running the command to update the kubeconfig file
resource "null_resource" "cluster" {
provisioner "local-exec" {
 command ="gcloud container clusters get-credentials ${google_container_cluster.gcp_cluster.name}  --region ${google_container_cluster.gcp_cluster.location} --project ${google_container_cluster.gcp_cluster.project}"
 }
}