# Multi-Cloud---RDS-on-AWS-GKE-on-GCP

# About the Project -

The motive is to deploy a Wordpress Application on Kubernetes using Terraform. For this, I have used the GKE services from Google Cloud Platform to deploy the Wordpress Server & RDS from Amazon Cloud to deploy the MySQL database which will be connected to Wordpress.
Thus, this project depicts a great example of Multi Cloud.



# Project Description :

Steps:

1- Write an Infrastructure as code using terraform, which automatically deploy the Wordpress application
2- On AWS, use RDS service for the relational database for Wordpress application.
3- Deploy the Wordpress as a container on top of Google Kubernetes Engine running on GCP.
4- The Wordpress application should be accessible from the public world.


# What is Wordpress ?

WordPress (WP, WordPress.org) is a free and open-source content management system (CMS) written in PHP and paired with a MySQL or MariaDB database. Features include a plugin architecture and a template system, referred to within WordPress as Themes. WordPress was originally created as a blog-publishing system but has evolved to support other types of web content including more traditional mailing lists and forums, media galleries, membership sites, learning management systems (LMS) and online stores. WordPress is used by more than 60 million websites, including 33.6% of the top 10 million websites as of April 2019, WordPress is one of the most popular content management system solutions in use. WordPress has also been used for other application domains such as pervasive display systems (PDS).


# What is GKE ?

Google Kubernetes Engine (GKE) provides a managed environment for deploying, managing, and scaling your containerized applications using Google infrastructure. The GKE environment consists of multiple machines (specifically, Compute Engine instances) grouped together to form a cluster.

**It is equivalent to Amazon EKS.**

(Here is a link to a mini project which I had created using Amazon EKS - https://github.com/sparshpnd23/Amazon-EKS)

GKE clusters are powered by the Kubernetes open source cluster management system. Kubernetes provides the mechanisms through which you interact with your cluster. You use Kubernetes commands and resources to deploy and manage your applications, perform administration tasks, set policies, and monitor the health of your deployed workloads.

Kubernetes draws on the same design principles that run popular Google services and provides the same benefits: automatic management, monitoring and liveness probes for application containers, automatic scaling, rolling updates, and more. When you run your applications on a cluster, you're using technology based on Google's 10+ years of experience running production workloads in containers.

Kubernetes on Google Cloud
When you run a GKE cluster, you also gain the benefit of advanced cluster management features that Google Cloud provides. These include:

- Google Cloud's load-balancing for Compute Engine instances.
- Node pools to designate subsets of nodes within a cluster for additional flexibility.
- Automatic scaling of your cluster's node instance count.
- Automatic upgrades for your cluster's node software.
- Node auto-repair to maintain node health and availability.
- Logging and monitoring with Google Cloud's operations suite for visibility into your cluster.


# What is Amazon RDS ?

Amazon Relational Database Service (or Amazon RDS) is a distributed relational database service by Amazon Web Services (AWS). It is a web service running "in the cloud" designed to simplify the setup, operation, and scaling of a relational database for use in applications. Administration processes like patching the database software, backing up databases and enabling point-in-time recovery are managed automatically. Scaling storage and compute resources can be performed by a single API call as AWS does not offer an ssh connection to RDS instances.

Amazon Relational Database Service (Amazon RDS) makes it easy to set up, operate, and scale a relational database in the cloud. It provides cost-efficient and resizable capacity while automating time-consuming administration tasks such as hardware provisioning, database setup, patching and backups. It frees you to focus on your applications so you can give them the fast performance, high availability, security and compatibility they need.

Amazon RDS is available on several database instance types - optimized for memory, performance or I/O - and provides you with six familiar database engines to choose from, including Amazon Aurora, PostgreSQL, MySQL, MariaDB, Oracle Database, and SQL Server. You can use the AWS Database Migration Service to easily migrate or replicate your existing databases to Amazon RDS.


# Steps :-

**Step - 1:**  First of all, configure your AWS profile in your local system using cmd. Fill your details & press Enter.


                  aws configure --profile Sparsh
                  AWS Access Key ID [****************WO3Z]:
                  AWS Secret Access Key [****************b/hJ]:
                  Default region name [ap-south-1]:
                  Default output format [None]:
                  
                  
 Also, download the Google Cloud SDK & login through your credentials in the GCP Cloud.
 
                 provider "google" {
                  credentials = file("${var.gcp_credentials_path}")
                  project     = var.gcp_project_id
                  region      = var.gcp_cur_region
                }
                
 
 ![](/multi_cloud_images/gcp.png)
 
 
**Step - 2:** Create a **var.tf** file in which we will store all the variables that we need to use in our code. This way, our code will be easy to modify in future. Instead of going and changing the values at all places, we will just need to change the values in this variable file.

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
 
 
 **Step - 3:** Now, we proceed to create our main file. Here, I have used the module approach. I have created separate modules for different works. Since, I have created a folder called modules, I have mentioned it as source in my **main.tf**.
 
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


**Step - 4:** Now, we need to create a VPC, Subnet & Firewall in GCP. 

“A Virtual Private Cloud (VPC) is a global private isolated virtual network partition that provides managed networking functionality for your Google Cloud Platform (GCP) resources.” The instances within the VPC have internal IP addresses and can communicate privately with each other across the globe.

Subnets are regional resources. Each subnet defines a range of IP addresses. Traffic to and from instances can be controlled with network firewall rules.

Google Cloud Platform (GCP) firewall rules let you allow or deny traffic to and from your virtual machine (VM) instances based on a configuration you specify. By creating a firewall rule, you specify a Virtual Private Cloud (VPC) network and a set of components that define what the rule does.

The terraform code for the same is as follows:-

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
        
        

**Step - 5:** Now, it's time to launch a GKE cluster. I have explained GKE above in detail. The terraform code to launch a GKE cluster is as follows :- 


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
          
          
          
**Step - 6:** Now, we need to launch our RDS database in AWS cloud. For that, we launch the reqd. VPC, Subnets, Internet Gateway & security groups on AWS. 

Amazon Virtual Private Cloud (Amazon VPC) lets you provision a logically isolated section of the AWS Cloud where you can launch AWS resources in a virtual network that you define. You have complete control over your virtual networking environment, including selection of your own IP address range, creation of subnets, and configuration of route tables and network gateways. You can use both IPv4 and IPv6 in your VPC for secure and easy access to resources and applications.

Subnet is “part of the network”, in other words, part of entire availability zone. Each subnet must reside entirely within one Availability Zone and cannot span zones.

An internet gateway is a horizontally scaled, redundant, and highly available VPC component that allows communication between your VPC and the internet. 

A security group acts as a virtual firewall for your EC2 instances to control incoming and outgoing traffic. Inbound rules control the incoming traffic to your instance, and outbound rules control the outgoing traffic from your instance. Security groups are associated with network interfaces.

The terraform code is as follows :-


        variable "aws_db_instance_storage_type"{}

        variable "aws_db_instance_engine"{}

        variable "aws_db_instance_engine_version"{}

        variable "aws_db_instance_instance_class"{}

        variable "aws_db_instance_db_name"{}

        variable "aws_db_instance_username"{}

        variable "aws_db_instance_password"{}

        variable "aws_db_instance_publicly_accessible"{}

        variable "aws_db_instance_skip_final_snapshot"{}


        resource "aws_vpc" "defaultvpc" {
                    cidr_block = "192.168.0.0/16"
                    instance_tenancy = "default"
                    enable_dns_hostnames = true
                    tags = {
                      Name = "sparsh_vpc"
                    }
                  }


        resource "aws_subnet" "sparsh_public_subnet" {
                    vpc_id = aws_vpc.defaultvpc.id
                    cidr_block = "192.168.0.0/24"
                    availability_zone = "ap-south-1a"
                    map_public_ip_on_launch = "true"
                    tags = {
                      Name = "sparsh_public_subnet"
                    }
                  }

        resource "aws_subnet" "sparsh_public_subnet2" {
                    vpc_id = aws_vpc.defaultvpc.id
                    cidr_block = "192.168.1.0/24"
                    availability_zone = "ap-south-1b"
                    map_public_ip_on_launch = "true"
                    tags = {
                      Name = "sparsh_public_subnet2"
                    }
                  }

        resource "aws_db_subnet_group" "default" {
          name       = "main"
          subnet_ids = [aws_subnet.sparsh_public_subnet.id,aws_subnet.sparsh_public_subnet2.id]

          tags = {
            Name = "My DB subnet group"
          }
        }

        resource "aws_internet_gateway" "sparsh_gw" {
                    vpc_id = aws_vpc.defaultvpc.id
                    tags = {
                      Name = "sparsh_gw"
                    }
                  }



        resource "aws_security_group" "sparsh_public_sg" {
                    depends_on=[google_container_cluster.gcp_cluster]
                    name        = "HTTP_SSH_PING"
                    description = "It allows HTTP SSH PING inbound traffic"
                    vpc_id      = aws_vpc.defaultvpc.id

         ingress {
            description = "TLS from VPC"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_blocks = ["0.0.0.0/0"]
            ipv6_cidr_blocks = ["::/0"]
          }

          egress {
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_blocks = ["0.0.0.0/0"]
            ipv6_cidr_blocks = ["::/0"]
          }



                      tags = {
                      Name = "HTTP_SSH_PING"
                    }
                  }


        resource "aws_db_instance" "wp_db" {
            depends_on=[aws_security_group.sparsh_public_sg]
                allocated_storage    = 20
                storage_type         = var.aws_db_instance_storage_type
                engine               = var.aws_db_instance_engine
                engine_version       = var.aws_db_instance_engine_version
                instance_class       = var.aws_db_instance_instance_class
                name                 = var.aws_db_instance_db_name
                username             = var.aws_db_instance_username
                password             = var.aws_db_instance_password
                parameter_group_name = "default.mysql5.7"
                publicly_accessible  = var.aws_db_instance_publicly_accessible
                skip_final_snapshot  = var.aws_db_instance_skip_final_snapshot
                vpc_security_group_ids = [aws_security_group.sparsh_public_sg.id]
                db_subnet_group_name = aws_db_subnet_group.default.name
         }


**Step - 7:** Now that everything is ready, we are fit to launch our WordPress server on top of GKE cluster. The terraform code for the same is as follows :-

            provider "kubernetes" {
                config_context_cluster="gke_${google_container_cluster.gcp_cluster.project}_${google_container_cluster.gcp_cluster.location}_${google_container_cluster.gcp_cluster.name}"
            }
            resource "kubernetes_service" "k8s" {
                depends_on=[aws_db_instance.wp_db,google_container_cluster.gcp_cluster]
                metadata{
                    name="wp"
                    labels={
                        env="test"
                        name="wp"
                    }
                }
                spec{
                    type="LoadBalancer"
                    selector={
                    app="wp"
                    }
                    port{
                        port=80
                        target_port=80
                    }
                }
            }
            output "ip_add"{
                value=kubernetes_service.k8s.load_balancer_ingress[0].ip
            }
            resource "kubernetes_deployment" "wp_deploy"{
                depends_on=[aws_db_instance.wp_db,google_container_cluster.gcp_cluster]
                metadata{
                    name="wp-deploy"
                    labels={
                        name="wp-deploy"
                        app="wp"
                    }
                }
                spec{
                    replicas=1
                    selector{
                        match_labels = {
                            app="wp"
                        }
                    }
                    template{
                        metadata{
                            name="wp-deploy"
                            labels={
                                app="wp"
                            }
                        }
                        spec{
                            container{
                                name="wp"
                                image="wordpress"
                                env{
                                    name="WORDPRESS_DB_HOST"
                                    value=aws_db_instance.wp_db.address
                                }
                                env{
                                    name="WORDPRESS_DB_USER"
                                    value=aws_db_instance.wp_db.username
                                }
                                env{
                                    name="WORDPRESS_DB_PASSWORD"
                                    value=aws_db_instance.wp_db.password
                                }
                                env{
                                    name="WORDPRESS_DB_NAME"
                                    value=aws_db_instance.wp_db.name
                                } 
                            }
                        }
                    }
                }
            }
            // open wordpress site in browser
            resource "null_resource" "open_wordpress" {
            provisioner "local-exec" {
            command ="start chrome ${kubernetes_service.k8s.load_balancer_ingress[0].ip}"
                }
            }
            
            
            
            
**Step - 8:** Now, we run our terraform code. For doing so, we first run the command **terraform init**. This will download the necessary plugins.

![](/multi_cloud_images/init.png)

Then, we run the command **terraform plan**. This will check the code and highlight the errors if they exist.

![](/multi_cloud_images/plan.png)

![](/multi_cloud_images/plan_done.png)

 Finally, we run the command **terraform apply --auto-approve**. This will run the code and create the mentioned resources on the configured AWS & GCP Clouds.
 
 ![](/multi_cloud_images/init.png)
 
 
 Finally, we will see the terraform local executioner open up our Wordpress site in our web browser.
 
 ![](/multi_cloud_images/wp.png)
 
 
 
 
 
 


**Congrats Guys !! We finally did it. We finally deployed our WordPress server on a Multi Cloud setup using a combination of Google Kubernetes Engine from Google Cloud & Amazon Relational Database Services from AWS Cloud.**
 
 ![](/multi_cloud_images/celebrate.jpg)
 
 
 P.S. - Any suggestions and improvements are warmly welcome.
 
 
 
