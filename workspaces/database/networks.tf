/*****************************************
  Networking
 *****************************************/

module "gcp-network" {
  source  = "terraform-google-modules/network/google"
  version = ">= 11.1"

  project_id   = var.project.id
  network_name = var.network_name

  subnets = [
    {
      subnet_name   = var.subnetwork.name
      subnet_ip     = var.subnetwork.cidr
      subnet_region = var.project.region
    },
  ]
}

module "cloud-nat" {
  source        = "terraform-google-modules/cloud-nat/google"
  version       = ">= 5.3.0"
  project_id    = var.project.id
  region        = var.project.region
  router        = var.router_name
  network       = module.gcp-network.network_name
  create_router = true
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider = google-beta

  network                 = module.gcp-network.network_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}
