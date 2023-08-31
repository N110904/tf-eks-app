resource "kubernetes_ingress_v1" "ingress_resource" {
   metadata {
      name        = var.ingress_resource
      annotations = {
        "nginx.ingress.kubernetes.io/rewrite-target" = "/$1"
        "kubernetes.io/ingress.class" = "nginx"
      }
   }
   spec {
      rule {
        http {
         path {
           path = "/"
           backend {
             service {
               name = var.ingress_forward_service
               port {
                 number = var.ingress_forward_port
               }
             }
           }
        }
         path {
           path = "/api"
           backend {
             service {
               name = "api-service"
               port {
                 number = 8080
               }
             }
           }
        }        
      }
    }
  }
}