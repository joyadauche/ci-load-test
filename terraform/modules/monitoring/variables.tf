variable "kube-prometheus-namespace" {
  type        = string
  description = "The namespace for in which kube-prometheus-stack objects would be created in"
  default     = "monitoring"
}

variable "kube-version" {
  type        = string
  description = "The helm version for the kube-prometheus-stack"
  default     = "56.4.0" # https://artifacthub.io/packages/helm/prometheus-community/kube-prometheus-stack
}
