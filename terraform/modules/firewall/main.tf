resource "google_compute_firewall" "fw-rule" {
  name      = var.name
  network   = var.network
  description = "Creates Firewall rule targetting tagged instances"

  allow {
    protocol = var.protocol
    ports    = var.ports
  }
  target_tags   = var.target_tags
  source_ranges = var.source_ranges
}
