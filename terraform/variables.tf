variable "cluster_name" {
  type        = string
  description = "The name of the cluster"
  default     = "ci-load-test"
}

variable "kubeconfig_path" {
  type        = string
  description = "The location of the kubeconfig file"
  default     = "~/.kube/config"
}

variable "ingress_nginx_helm_version" {
  type        = string
  description = "The helm version for the nginx ingress controller"
  default     = "4.7.3" # https://github.com/kubernetes/ingress-nginx/releases
}

variable "ingress_nginx_namespace" {
  type        = string
  description = "The namespace for the nginx ingress controller"
  default     = "ingress-nginx"
}
