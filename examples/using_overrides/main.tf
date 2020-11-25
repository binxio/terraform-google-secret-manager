locals {
  owner       = "myself"
  project     = "demo"
  environment = "dev"

  purpose = "override-test"
  roles = {
    "roles/secretmanager.admin" = {
      (var.sa_owner_email) = "serviceAccount"
    }
    "roles/secretmanager.secretAccessor" = {
      (var.sa_reader_email) = "serviceAccount"
    }
  }

  replication = {
    user_managed = [
      {
        replicas = [
          {
            location = "europe-west1"
          }
        ]
      }
    ]
  }
}

module "secret" {
  source  = "binxio/secret-manager/google"
  version = "~> 1.0.0"

  owner       = local.owner
  project     = local.project
  environment = local.environment

  purpose     = local.purpose
  roles       = local.roles
  replication = local.replication
}
