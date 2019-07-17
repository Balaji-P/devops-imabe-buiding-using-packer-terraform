# Configure the Google Cloud provider
provider "google" {
  project = var.project_id
  region  = var.region
}

# Create two firewall via module (of course, we can make one with different ports)
module firewall-ssh {
  source = "./modules/firewall"
  name = "ssh-22"
  network = var.network
  protocol = "tcp"
  ports = ["22"]
  source_ranges = var.ip_ranges
  target_tags = [var.nginx-tag]
}

module firewall-http {
  source = "./modules/firewall"
  name = "http-80"
  network = var.network
  protocol = "tcp"
  ports = ["80"]
  source_ranges = var.ip_ranges
  target_tags = [var.nginx-tag]
}

# Create a Google Compute instance
resource "google_compute_instance" "nginx" {
  name         = var.nginx-name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = var.network

    access_config {
      // Left this field to get the output
    }
  }

  tags = [var.nginx-tag]
}

# Output variable: Public IP address
output "nginx_public_ip" {
  value = google_compute_instance.nginx.network_interface.0.access_config.0.nat_ip
}