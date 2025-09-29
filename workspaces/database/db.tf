/*****************************************
  IP
 *****************************************/

# Reserve a static internal IP address for Cloud SQL:
resource "google_compute_global_address" "private_ip_address" {
  provider = google-beta
  name     = "${var.project.id}-cloudsql-private-ip"

  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = module.gcp-network.network_id
}

/*****************************************
  Database Instance
 *****************************************/

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "instance" {
  provider            = google-beta
  database_version    = var.db_version
  depends_on          = [google_service_networking_connection.private_vpc_connection]
  name                = "${var.cloudsql_instance_name}-${random_id.db_name_suffix.hex}"
  region              = var.project.region
  deletion_protection = false

  settings {
    tier = var.machine_type

    ip_configuration {
      ipv4_enabled    = true
      private_network = module.gcp-network.network_id
      authorized_networks {
        name  = "allow-all"
        value = "0.0.0.0/0"
      }
      enable_private_path_for_google_cloud_services = false
    }

    database_flags {
      name  = "max_connections"
      value = "1000"
    }

  }
}

/*****************************************
  DB and USERs
 *****************************************/
resource "google_sql_database" "app" {
  name     = var.db_name
  instance = google_sql_database_instance.instance.name
}

resource "google_sql_user" "app_user" {
  name     = var.db_user
  instance = google_sql_database_instance.instance.name
  password = var.db_pass
}
