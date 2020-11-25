locals {
  project     = "testapp"
  environment = var.environment

  purpose = "default-test"
}

module "secret" {
  source = "../../modules/secret"

  owner       = var.owner
  project     = local.project
  environment = local.environment

  purpose = local.purpose

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

output "id" {
  value = module.secret.id
}
