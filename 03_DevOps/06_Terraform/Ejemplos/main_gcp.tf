terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("bootcamp-cloud-thebridge-30ceee401cac.json")

  project = "bootcamp-cloud-thebridge"
  region  = "europe-west1"
  zone    = "europe-west1-b"
}

resource "google_compute_network" "vpc" {
  name = "terraform-network"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10" # Si la versión cambia 
    }
  }

  network_interface {
    network = google_compute_network.vpc.name
    access_config {
    }
  }
}


resource "google_compute_firewall" "vpc_firewall" {
  name    = "test-firewall"
  network = google_compute_network. vpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }

  source_tags = ["web"]
}
