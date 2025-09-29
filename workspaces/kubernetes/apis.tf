/*****************************************
  Google APIs
 *****************************************/

# Enable the Artifact Registry API
resource "google_project_service" "artifactregistry_api" {
  project = var.project.id
  service = "artifactregistry.googleapis.com"

  disable_dependent_services = false
  disable_on_destroy         = false
}

# Enable the Container Registry API (for compatibility)
resource "google_project_service" "containerregistry_api" {
  project = var.project.id
  service = "containerregistry.googleapis.com"

  disable_dependent_services = false
  disable_on_destroy         = false
}

# Enable the Kubernetes Engine API (if not already enabled)
resource "google_project_service" "gke_api" {
  project = var.project.id
  service = "container.googleapis.com"

  disable_dependent_services = false
  disable_on_destroy         = false
}

# Enable the Compute Engine API (required for GKE)
resource "google_project_service" "compute_api" {
  project = var.project.id
  service = "compute.googleapis.com"

  disable_dependent_services = false
  disable_on_destroy         = false
}
