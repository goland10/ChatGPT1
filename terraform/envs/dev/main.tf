locals {
  environment  = "dev"
  cluster_name = "gke-${local.environment}-me-west1"
}

module "network" {
  source = "../../modules/network"
  region = var.region
}

module "gke" {
  source = "../../modules/gke"

  project_id = var.project_id
  region     = var.region

  cluster_name = local.cluster_name
  environment  = local.environment

  network    = module.network.vpc_id
  subnetwork = module.network.subnet_id

  pods_range_name     = "pods"
  services_range_name = "services"
}
