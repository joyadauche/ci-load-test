resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = var.kube-prometheus-namespace
  }
}

resource "helm_release" "kube-prometheus" {
  name       = "kube-prometheus-stack"
  namespace  = var.kube-prometheus-namespace
  version    = var.kube-version
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"

  depends_on = [kubernetes_namespace.monitoring]
}
