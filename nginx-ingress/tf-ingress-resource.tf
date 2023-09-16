resource "kubernetes_ingress_v1" "ingress_resource" {
   metadata {
      name        = var.ingress_resource
      annotations = {
        ##"nginx.ingress.kubernetes.io/rewrite-target" = "/$1"
        "kubernetes.io/ingress.class" = "nginx"
      }
   }
   spec {
      rule {
        http {
        #WEB routing
         path {
           path = "/"
           backend {
             service {
               name = "web-service"
               port {
                 number = 80
               }
             }
           }
        }

      ##API routing
         path {
           path = "/api"
           path_type = "Prefix"      ##"/api(/|$)(.*)" /(|$/|$)(.*)
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