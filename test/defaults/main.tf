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
}

output "id" {
  value = module.secret.id
}
