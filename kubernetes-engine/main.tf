terraform {
  backend "gcs" {
    bucket = "saifuls-playground"
    prefix = "sate-files/kubernetes-engine"
  }
}

# Configure GCP provider to use
provider "google" {
  project = "saifuls-playground"
  region  = "us-central1"
  zone    = "us-central1-c"
}
resource "kubernetes_service_account" "preexisting" {
  metadata {
    name = "my-application-name"
    namespace = "default"
    annotations = {
      "iam.gke.io/gcp-service-account" = "my-application-name@saifuls-playground.iam.gserviceaccount.com"
    }
  }
}

module "my-app-workload-identity" {
   source    = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  name      = "my-application-name"
  namespace = "default"
  project_id   = "saifuls-playground"
    use_existing_k8s_sa = true

}

output "k8s_service_account_name" {
  value = module.my-app-workload-identity.k8s_service_account_name
}


