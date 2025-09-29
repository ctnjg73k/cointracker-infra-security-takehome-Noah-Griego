/*****************************************
  Outputs
 *****************************************/

# Artifact Registry repository URL for hello-world-app
output "artifact_registry_url" {
  description = "The URL of the Artifact Registry repository for hello-world-app"
  value       = "${var.project.region}-docker.pkg.dev/${var.project.id}/${google_artifact_registry_repository.hello_world_app_repo.repository_id}"
}

# Full image path template for hello-world-app
output "hello_world_app_image_path" {
  description = "Full image path template for hello-world-app (without tag)"
  value       = "${var.project.region}-docker.pkg.dev/${var.project.id}/${google_artifact_registry_repository.hello_world_app_repo.repository_id}/hello-world-app"
}

# GKE Service Account email
output "gke_service_account_email" {
  description = "Email of the GKE service account"
  value       = google_service_account.gke_service_account.email
}

# GKE cluster endpoint
output "gke_cluster_endpoint" {
  description = "GKE cluster endpoint"
  value       = module.gke.endpoint
  sensitive   = true
}

# GKE cluster name
output "gke_cluster_name" {
  description = "GKE cluster name"
  value       = module.gke.name
}
