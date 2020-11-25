variable "secret_id" {
  description = "The full id of the secret for which to create a version for"
  type        = string
}

variable "secret_data" {
  description = "The data to be set"
  type        = string
}
