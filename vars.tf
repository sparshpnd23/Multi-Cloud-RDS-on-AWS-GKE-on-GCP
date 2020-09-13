variable "gcp_credentials_path"{

    default="C:\\Users\\AAAA\\AppData\\Roaming\\gcloud\\My First Project-a04023bd5af9.json"
}


variable "gcp_project_id"{


     default="iconic-rampart-287215"
}


variable "gcp_cur_region"{


      default="asia-south1"
}




variable "aws_profile"{
    
    default="Sparsh"
}


variable "aws_region"{
   
   default= "ap-south-1"
}

variable "gcp_vpc_name"{

    default = "gcp-vpc"

}

variable "subnet_gcp_name"{
    default = "subnet-vpc"
}

variable "subnet_ip_cidr_range"{
    default = "10.0.2.0/24"
}

variable "gcp_subnet_region"{
    default = "asia-southeast1"
}

variable "gcp_compute_firewall"{
    default = "firewall-gcp"
}

variable "allowed_ports"{

    type=list
    default=["80","22"]

}


variable "google_container_cluster_name"{

    default="gcp-cluster"
}

variable "google_container_cluster_location"{
    default = "asia-southeast1"
}

variable "gcp_node_config_machine_type"{
    default = "n1-standard-1"
}


variable "aws_db_instance_storage_type"{
    default = "gp2"
}

variable "aws_db_instance_engine"{
default = "mysql"
}

variable "aws_db_instance_engine_version"{
default = 5.7
}

variable "aws_db_instance_instance_class"{
default = "db.t2.micro"
}

variable "aws_db_instance_db_name"{
default = "db"
}

variable "aws_db_instance_username"{
default = "admin"
}

variable "aws_db_instance_password"{
default = "sparsh"
}

variable "aws_db_instance_publicly_accessible"{
default = true
}

variable "aws_db_instance_skip_final_snapshot"{
default = true
}