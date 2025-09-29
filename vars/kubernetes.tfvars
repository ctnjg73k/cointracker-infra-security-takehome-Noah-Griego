component_name = "kubernetes"
network_name   = "assignment-kubernetes-network"
router_name    = "assignment-gke-router"
cluster_name   = "assignment"

machine_type = "e2-standard-4"
min_count    = 2
max_count    = 4
subnetwork = {
  name = "assignment-kubernetes-subnetwork"
  cidr = "10.0.0.0/17"
}

ip_range_services = {
  name = "assignment-cidr-service"
  cidr = "192.168.64.0/18"
}

ip_range_pods = {
  name = "assignment-cidr-pods"
  cidr = "192.168.0.0/18"
}
