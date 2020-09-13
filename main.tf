provider "google" {
  credentials = file("${var.gcp_credentials_path}")
  project     = var.gcp_project_id
  region      = var.gcp_cur_region
}


provider "aws" {
profile   = var.aws_profile
  region  = var.aws_region
}


module "gcp_aws"{

 source = "./modules"

gcp_project_id=var.gcp_project_id
gcp_vpc_name=var.gcp_vpc_name
subnet_gcp_name=var.subnet_gcp_name
subnet_ip_cidr_range=var.subnet_ip_cidr_range
gcp_subnet_region=var.gcp_subnet_region
gcp_compute_firewall=var.gcp_compute_firewall
allowed_ports=var.allowed_ports



google_container_cluster_name=var.google_container_cluster_name
google_container_cluster_location=var.google_container_cluster_location
gcp_node_config_machine_type=var.gcp_node_config_machine_type



aws_db_instance_storage_type=var.aws_db_instance_storage_type
aws_db_instance_engine=var.aws_db_instance_engine
aws_db_instance_engine_version=var.aws_db_instance_engine_version
aws_db_instance_instance_class=var.aws_db_instance_instance_class
aws_db_instance_db_name=var.aws_db_instance_db_name
aws_db_instance_username=var.aws_db_instance_username
aws_db_instance_password=var.aws_db_instance_password
aws_db_instance_publicly_accessible=var.aws_db_instance_publicly_accessible
aws_db_instance_skip_final_snapshot=var.aws_db_instance_skip_final_snapshot

}