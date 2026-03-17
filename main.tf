
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}


provider "google" {
  project = "hello-490500"
  region  = "us-central1"
  zone    = "us-central1-a"
}


resource "google_compute_firewall" "default" {
  name    = "allow-http-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web-server"]
}


resource "google_compute_instance" "node_server" {
  name         = "hello-world-node-vm"
  machine_type = "e2-micro" 
  tags         = ["web-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {
      
    }
  }

  
  metadata_startup_script = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
  EOF
}


output "ip_publico" {
  value = google_compute_instance.node_server.network_interface[0].access_config[0].nat_ip
}