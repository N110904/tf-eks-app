terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

 provider "kubernetes" {
   config_path = "~/.kube/config"  # Path to your Kubernetes config file in case of local setup
 }

 provider "helm" {
   kubernetes {
     config_path = "~/.kube/config"  # Path to your Kubernetes config file in case of local setup
   }
 }

#provider "helm" {
#  kubernetes {
#    host                   = data.aws_eks_cluster.cluster.endpoint
#    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
#    token                  = data.aws_eks_cluster_auth.cluster.token
#
#  }
#}

#provider "kubernetes" {
#  host                   = data.aws_eks_cluster.cluster.endpoint
#  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
#  token                  = data.aws_eks_cluster_auth.cluster.token
#
#}