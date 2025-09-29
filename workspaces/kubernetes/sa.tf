/*****************************************
  IAM Bindings GKE SVC
 *****************************************/

resource "google_service_account" "gke_service_account" {
  project      = var.project.id
  account_id   = "${var.component_name}-gke-sa"
  display_name = "GKE Service Account"
}

# Grant the service account permission to pull images from Artifact Registry
resource "google_project_iam_member" "gke_artifact_registry_reader" {
  project = var.project.id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.gke_service_account.email}"
}

# Grant the service account permission to read from storage (for layer pulls)
resource "google_project_iam_member" "gke_storage_object_viewer" {
  project = var.project.id
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.gke_service_account.email}"
}
