variable "ingress_controller" {
  description = "Value will be passed from main.tf"
}

variable "ingress_resource" {
  description = "Value will be passed from main.tf"
}

variable "ingress_forward_service" {
  description = "Value will be passed from main.tf"
}

variable "ingress_forward_port" {
  description = "Value will be passed from main.tf"
  type = number
}