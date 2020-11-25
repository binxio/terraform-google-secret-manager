locals {
  project     = "testapp"
  environment = var.environment
}

module "secret1" {
  source = "../../modules/secret"

  owner       = var.owner
  project     = local.project
  environment = local.environment

  purpose = "trigger-assertions for secret by creating too long sentences as it is only allowed to be 255 chars or less but we have to keep going as we are not there yet as somehow GCP decided to go way over the other resoure limits where a name can only be 30 chars orso while we would want them to be longer"
}

module "secret2" {
  source = "../../modules/secret"

  owner       = var.owner
  project     = local.project
  environment = local.environment

  purpose = "trigger-assertions for secret 'cause this name contains invalid chars."
}
