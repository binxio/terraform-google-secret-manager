#------------------------------------------------------------------------------------------------------------------------
# 
# Generic variables
#
#------------------------------------------------------------------------------------------------------------------------
variable "owner" {
  description = "Owner of the resource. This variable is used to set the 'owner' label. Will be used as default for each subnet, but can be overridden using the subnet settings."
  type        = string
}

variable "project" {
  description = "Company project name."
  type        = string
}

variable "environment" {
  description = "Company environment for which the resources are created (e.g. dev, tst, acc, prd, all)."
  type        = string
}

#------------------------------------------------------------------------------------------------------------------------
#
# secret variables
#
#------------------------------------------------------------------------------------------------------------------------
variable "purpose" {
  description = "The purpose of the secret. This variable is appended to the secret_id and used to set the 'purpose' label."
  type        = string
}

variable "replication" {
  description = "The replication to be used"
  type        = any
  default = {
    automatic = true
  }
}

variable "roles" {
  description = "Map of role name's as `key` and members list as `value` to bind permissions"
  type        = map(map(string))
  default     = {}
}
