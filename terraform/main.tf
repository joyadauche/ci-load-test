module "kind-cluster" {
  source          = "./modules/cluster"
  cluster_name    = var.cluster_name
  kubeconfig_path = var.kubeconfig_path
}
