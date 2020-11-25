output "id" {
  description = "The resource name of the SecretVersion. Format: projects/{{project}}/secrets/{{secret_id}}/versions/{{version}}"
  value       = google_secret_manager_secret_version.version.id
}
