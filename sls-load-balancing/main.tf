#
#Serverless load balancing with Terraform: The hard way using Terraform.
#https://cloud.google.com/blog/topics/developers-practitioners/serverless-load-balancing-terraform-hard-way
#
#Args:
#- project (str): The GCP project ID to deploy the connector in.
#- db_pass (str): The root password for the database instance.
#
#Returns:
#- None
# Configure Terraform backend to store state file in GCS

terraform {
  backend "gcs" {
    bucket = "saifuls-playground"
    prefix = "sate-files/sls-load-balancing"
  }
}


provider "google" {
  project = "saifuls-playground"
  region  = "us-central1"
  zone    = "us-central1-c"
}
variable "region" {
  default = "us-central1"
}
variable "project" {
  default = "saifuls-playground"
}
resource "google_cloud_run_service" "default" {
  name     = "hello"
  location = var.region
  project  = var.project

  template {
    spec {
      containers {
        image = "gcr.io/cloudrun/hello"
      }
    }
  }
}

resource "google_cloud_run_service_iam_member" "member" {
  location = google_cloud_run_service.default.location
  project  = google_cloud_run_service.default.project
  service  = google_cloud_run_service.default.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
variable "name" {
  default = "default"
}
resource "google_compute_global_address" "default" {
  name = "${var.name}-address"
}
variable "domain" {
  default = "hellofractalslab.com"
}
resource "google_compute_managed_ssl_certificate" "default" {
  name = "${var.name}-cert"
  managed {
    domains = [var.domain]
  }
}
resource "google_compute_region_network_endpoint_group" "cloudrun_neg" {
  name                  = "${var.name}-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  project               = var.project
  cloud_run {
    service = google_cloud_run_service.default.name
  }
}
resource "google_compute_backend_service" "default" {
  name        = "${var.name}-backend"
  protocol    = "HTTP"
  port_name   = "http"
  timeout_sec = 30

  backend {
    group = google_compute_region_network_endpoint_group.cloudrun_neg.id
  }
}

resource "google_compute_url_map" "default" {
  name = "${var.name}-urlmap"
  default_service = google_compute_backend_service.default.id
}
resource "google_compute_target_https_proxy" "default" {
  name = "${var.name}-https-proxy"

  url_map          = google_compute_url_map.default.id
  ssl_certificates = [
    google_compute_managed_ssl_certificate.default.id
  ]
}
resource "google_compute_global_forwarding_rule" "default" {
  name = "${var.name}-lb"

  target     = google_compute_target_https_proxy.default.id
  port_range = "443"
  ip_address = google_compute_global_address.default.address
}
output "load_balancer_ip" {
  value = google_compute_global_address.default.address
}
resource "google_compute_url_map" "https_redirect" {
  name = "${var.name}-https-redirect"

  default_url_redirect {
    https_redirect         = true
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query            = false
  }
}

resource "google_compute_target_http_proxy" "https_redirect" {
  name    = "${var.name}-http-proxy"
  url_map = google_compute_url_map.https_redirect.id
}

resource "google_compute_global_forwarding_rule" "https_redirect" {
  name = "${var.name}-lb-http"

  target     = google_compute_target_http_proxy.https_redirect.id
  port_range = "80"
  ip_address = google_compute_global_address.default.address
}