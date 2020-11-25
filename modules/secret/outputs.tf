output "secret_id" {
  description = "Id of the secret"
  value       = google_secret_manager_secret.secret.secret_id
}

output "id" {
  description = "Id of the secret"
  value       = google_secret_manager_secret.secret.id
}
