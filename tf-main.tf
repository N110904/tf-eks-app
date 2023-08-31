##To fetch required data from remote state of infra 
data "terraform_remote_state" "k8s_infra_state" {
  backend = "s3"

  config = {
    bucket         = "my-tf-remote-state-958198"
    key            = "terraform_infra.tfstate"
    region         = "us-west-1"
    encrypt        = true
    ##dynamodb_table = "my-lock-table"
  }
}

data "aws_eks_cluster" "cluster" {
  name = terraform_remote_state.k8s_infra_state.outputs.cluster_name
}

module nginx_ingress_web{
    source = "./nginx-ingress"

    ingress_controller = var.web_ingress_controller
    ingress_resource = var.web_ingress_resource
    ingress_forward_service = var.web_ingress_forward_service
    ingress_forward_port = var.web_ingress_forward_port
}

module nginx_ingress_api{
    source = "./nginx-ingress"

    ingress_controller = var.api_ingress_controller
    ingress_resource = var.api_ingress_resource
    ingress_forward_service = var.api_ingress_forward_service
    ingress_forward_port = var.api_ingress_forward_port    
}

module api{
    source = "./api"
}

module web{
    source = "./web"
}