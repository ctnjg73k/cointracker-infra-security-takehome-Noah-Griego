resource "google_compute_firewall" "allow_local_trafic_rule" {
  name    = "allow-local-trafic-rule-gke"
  network = module.gcp-network.network_name

  allow {
    protocol = "all"
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_google_ssh_rule" {
  name    = "allow-google-ssh-gke"
  network = module.gcp-network.network_name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}
