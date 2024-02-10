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
