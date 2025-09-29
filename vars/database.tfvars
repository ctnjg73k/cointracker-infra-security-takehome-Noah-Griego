component_name         = "database"
network_name           = "assignment-db-network"
router_name            = "assignment-db-router"
cloudsql_instance_name = "assignment-cloudsql"

machine_type = "db-f1-micro"

subnetwork = {
  name = "assignment-db-subnetwork"
  cidr = "10.0.0.0/24"
}
db_name = "test"
db_user = "user_test"
db_pass = "user_test"
