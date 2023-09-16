### WEB Deployment Resource
### WEB Service Resource
### WEB HPA Resource

resource "kubernetes_deployment" "web_deployment" {
  metadata {
    name = "web-deployment"
    labels = {
      app = "web-app"
    }
    annotations = {
      description = "web Deployment"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "web-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "web-app"
        }
        annotations = {
          version = "1.0"
        }
      }

      spec {
        container {
          image = "bashacse/angular:k8s_poc"
          name  = "web-container"

          port {
            container_port = 80
          }

          env {
            name = "API_URL"
            ##value = "http://api-service.default.svc.cluster.local:8080"
            value = "http://a9f39214ada2a43c2b0902beb331790d-31329889.us-east-1.elb.amazonaws.com"
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

resource "kubernetes_service" "web_service" {
  metadata {
    name = "web-service"
  }

  spec {
    selector = {
      app = "web-app"
    }

    port {
      port        = 80
      target_port = 80
    }
  }
}

resource "kubernetes_horizontal_pod_autoscaler" "web_hpa" {
  metadata {
    name = "web-hpa"
  }

  spec {
    min_replicas = 2
    max_replicas = 4    
    target_cpu_utilization_percentage = 50
    scale_target_ref {
      kind = "Deployment"
      name = kubernetes_deployment.web_deployment.metadata.0.name
      api_version = "apps/v1"
    }
}
}