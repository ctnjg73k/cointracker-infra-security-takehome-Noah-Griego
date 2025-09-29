locals {
  proxy_instance_name = "${var.cloudsql_instance_name}-proxy"
  network_tag         = "cloudsql-proxy"
}
