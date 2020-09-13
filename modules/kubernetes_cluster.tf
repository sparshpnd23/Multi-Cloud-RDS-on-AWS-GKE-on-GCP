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
// open wordpress site on browser
resource "null_resource" "open_wordpress" {
provisioner "local-exec" {
command ="start chrome ${kubernetes_service.k8s.load_balancer_ingress[0].ip}"
    }
}