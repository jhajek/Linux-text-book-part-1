variable "headless_build" {
  type =  bool
  default = false
}

variable "memory_amount" {
  type =  string
  default = "4096"
}

# Syntax
# https://developer.hashicorp.com/packer/docs/templates/hcl_templates/functions/contextual/vault
locals {
  user-ssh-password = vault("/secret/data/team00-ssh","SSHPASS")
}

variable "build_artifact_location" {
 
 # If building on your local laptop use the ../build path
  type = string
  default = "../build/"

}

# Syntax
# https://developer.hashicorp.com/packer/docs/templates/hcl_templates/functions/contextual/vault
locals {
  db_user = vault("/secret/data/team00-db", "DBUSER")
}
