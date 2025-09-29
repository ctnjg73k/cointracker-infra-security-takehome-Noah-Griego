/*****************************************
  Database Outputs
 *****************************************/

# Database instance name
output "database_instance_name" {
  description = "The name of the Cloud SQL database instance"
  value       = google_sql_database_instance.instance.name
}

# Database public IP address
output "database_public_ip" {
  description = "The public IP address of the Cloud SQL database instance"
  value       = google_sql_database_instance.instance.public_ip_address
}

# Database private IP address
output "database_private_ip" {
  description = "The private IP address of the Cloud SQL database instance"
  value       = google_sql_database_instance.instance.private_ip_address
}

# Database connection name (for Cloud SQL Proxy)
output "database_connection_name" {
  description = "The connection name for the Cloud SQL instance (used by Cloud SQL Proxy)"
  value       = google_sql_database_instance.instance.connection_name
}

# Database name
output "database_name" {
  description = "The name of the database"
  value       = google_sql_database.app.name
}

# Database user
output "database_user" {
  description = "The database user"
  value       = google_sql_user.app_user.name
}

# Database password (sensitive)
output "database_password" {
  description = "The database password"
  value       = google_sql_user.app_user.password
  sensitive   = true
}

# Full PostgreSQL connection URI for public IP
output "database_public_uri" {
  description = "Full PostgreSQL connection URI using public IP"
  value       = "postgresql://${google_sql_user.app_user.name}:${google_sql_user.app_user.password}@${google_sql_database_instance.instance.public_ip_address}:5432/${google_sql_database.app.name}"
  sensitive   = true
}

# Full PostgreSQL connection URI for private IP
output "database_private_uri" {
  description = "Full PostgreSQL connection URI using private IP"
  value       = "postgresql://${google_sql_user.app_user.name}:${google_sql_user.app_user.password}@${google_sql_database_instance.instance.private_ip_address}:5432/${google_sql_database.app.name}"
  sensitive   = true
}
