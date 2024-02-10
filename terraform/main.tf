module "kind-cluster" {
  source                     = "./modules/cluster"
  cluster_name               = var.cluster_name
  kubeconfig_path            = var.kubeconfig_path
  ingress_nginx_helm_version = var.ingress_nginx_helm_version
  ingress_nginx_namespace    = var.ingress_nginx_namespace
}

module "kube-prometheus" {
  source = "./modules/monitoring"
}
