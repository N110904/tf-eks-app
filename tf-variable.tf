variable "web_ingress_controller" {
  default = "ingress-controller-web"
  description = "ingress controller name for webapp"
}

variable "web_ingress_resource" {
  default = "ingress-resource-web"
  description = "ingress resource name for webapp"
}

variable "web_ingress_forward_service" {
  default = "web-service"
  description = "webapp service name to foward traffic from ingress"
}

variable "web_ingress_forward_port" {
  default = 80
  description = "webapp port to foward traffic from ingress"
  type = number
}

variable "api_ingress_controller" {
  default = "ingress-controller-api"
  description = "ingress controller name for apiapp"
}

variable "api_ingress_resource" {
  default = "ingress-resource-api"
  description = "ingress resource name for apiapp"
}

variable "api_ingress_forward_service" {
  default = "api-service"
  description = "api service name to foward traffic from ingress"
}

variable "api_ingress_forward_port" {
  default = 8080
  description = "api port to foward traffic from ingress"
  type = number
}