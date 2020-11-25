locals {
  owner       = "myself"
  project     = "demo"
  environment = "dev"

  purpose = "default-test"
}

module "secret" {
  source  = "binxio/secret-manager/google"
  version = "~> 1.0.0"

  owner       = local.owner
  project     = local.project
  environment = local.environment

  purpose = local.purpose
}
