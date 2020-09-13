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


