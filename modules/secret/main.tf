locals {
  project     = var.project
  environment = var.environment
  owner       = var.owner

  labels = {
    "project" = substr(replace(lower(local.project), "/[^\\p{Ll}\\p{Lo}\\p{N}_-]+/", "_"), 0, 63)
    "env"     = substr(replace(lower(local.environment), "/[^\\p{Ll}\\p{Lo}\\p{N}_-]+/", "_"), 0, 63)
    "owner"   = substr(replace(local.owner, "/[^\\p{Ll}\\p{Lo}\\p{N}_-]+/", "_"), 0, 63)
    "creator" = "terraform"
  }

  # We like to have the project and env in the secret name, so it's obvious what the secret belongs to
  # without checking the GCP project it's part of
  # This also allows for central secret management since the naming is more unique by default.
  secret_id = replace(lower(format("%s-%s-%s", local.project, local.environment, var.purpose)), " ", "-")

  # Map role members to GCP expected format
  roles = { for role, members in try(var.roles, {}) : role => [for member, type in members : format("%s:%s", type, member)] }
}

resource "google_secret_manager_secret" "secret" {
  secret_id = local.secret_id

  replication {
    automatic = try(var.replication.automatic, null)

    dynamic "user_managed" {
      for_each = try(var.replication.user_managed, [])

      content {
        dynamic "replicas" {
          for_each = try(user_managed.value.replicas, [])

          content {
            location = replicas.value.location
          }
        }
      }
    }
  }

  labels = local.labels
}

data "google_iam_policy" "map" {
  for_each = (length(keys(local.roles)) > 0 ? { policy = {} } : {})

  dynamic "binding" {
    for_each = local.roles

    content {
      role    = binding.key
      members = binding.value
    }
  }
}

resource "google_secret_manager_secret_iam_policy" "map" {
  for_each = data.google_iam_policy.map

  secret_id   = google_secret_manager_secret.secret.secret_id
  policy_data = each.value.policy_data
}
