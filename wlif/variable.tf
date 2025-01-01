variable "rolesList" {
  type    = list(string)
  default = ["roles/artifactregistry.admin", "roles/run.admin", "roles/iam.serviceAccountUser"]
}
variable "region" {
  default = "us-west1"
}
variable "zone" {
  default = "us-west1-a"
}
variable "project_id" {
  default = "stg-lsx-ntry2z8h"
}
variable "service_account_id" {
  default = "github-action-sa"
}
variable "pool_id" {
  default = "github-action-pool"
}
variable "provider_id" {
  default = "github-action"
}
variable "git_repo" {
  default = "attribute.repository/AllStripes/life-sciences-experience"
}

