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


 