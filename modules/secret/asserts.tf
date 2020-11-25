#######################################################################################################
#
# Terraform does not have a easy way to check if the input parameters are in the correct format.
# On top of that, terraform will sometimes produce a valid plan but then fail during apply.
# To handle these errors beforehad, we're using the 'file' hack to throw errors on known mistakes.
#
#######################################################################################################
locals {
  # Regular expressions
  regex_secret_id   = "[a-zA-Z0-9](?:[a-zA-Z0-9_-]{4,253}[a-zA-Z0-9])"

  # Terraform assertion hack
  assert_head = "\n\n-------------------------- /!\\ ASSERTION FAILED /!\\ --------------------------\n\n"
  assert_foot = "\n\n-------------------------- /!\\ ^^^^^^^^^^^^^^^^ /!\\ --------------------------\n"
  asserts = {
    secret_id_too_long   = length(local.secret_id) > 255 ? file(format("%sSecret's generated id is too long:\n%s\n%s > 255 chars!%s", local.assert_head, local.secret_id, length(local.secret_id), local.assert_foot)) : "ok"
    secret_id_regex      = length(regexall("^${local.regex_secret_id}$", local.secret_id)) == 0 ? file(format("%sSecret's generated id [%s] does not match regex ^%s$%s", local.assert_head, local.secret_id, local.regex_secret_id, local.assert_foot)) : "ok"
  }
}
