### API Deployment Resource
### API Service Resource
### API HPA Resource

resource "kubernetes_deployment" "api_deployment" {
  metadata {
    name = "api-deployment"
    labels = {
      app = "api-app"
    }
    annotations = {
      description = "api Deployment"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "api-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "api-app"
        }
        annotations = {
          version = "1.0"
        }
      }

      spec {
        container {
          image = "nginx:latest"
          name  = "api-container"

          port {
            container_port = 8080
          }

          env {
            name = "SPRING_DATASOURCE_URL"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map.api_configmap.metadata[0].name
                key  = "mysql-url"
              }
            }
          } 

          env {
            name = "MYSQL_DATABASE"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map.api_configmap.metadata[0].name
                key  = "mysql-database"
              }
            }
          }

          env {
            name = "SPRING_DATASOURCE_USERNAME"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map.api_configmap.metadata[0].name
                key  = "mysql-user"
              }
            }
          }

          env {
            name = "SPRING_DATASOURCE_PASSWORD"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map.api_configmap.metadata[0].name
                key  = "mysql-password"
              }
            }
          }                             
          
          resources {
            requests = {
              cpu    = "100m"
              memory = "128Mi"
            }
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "api_service" {
  metadata {
    name = "api-service"
  }

  spec {
    selector = {
      app = "api-app"
    }

    port {
      port        = 8080
      target_port = 8080
    }
  }
}

resource "kubernetes_horizontal_pod_autoscaler" "api_hpa" {
  metadata {
    name = "api-hpa"
  }

  spec {
    min_replicas = 2
    max_replicas = 4    
    target_cpu_utilization_percentage = 50
    scale_target_ref {
      kind = "Deployment"
      name = kubernetes_deployment.api_deployment.metadata.0.name
      api_version = "apps/v1"
    }
}
}