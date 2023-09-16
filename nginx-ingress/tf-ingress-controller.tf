resource "helm_release" "nginx-ingress-controller" {
  name       = var.ingress_controller
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"


  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "controller.ingressClass"
    value = var.ingress_class # Set your desired IngressClass name here
  }
}