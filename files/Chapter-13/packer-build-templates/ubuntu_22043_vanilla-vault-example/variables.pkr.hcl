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

 # If building on the school build-server use this default value
  # This is the default path on the build-server to place the .box files for download via a webserver
  # default = "/datadisk2/boxes/jrh-"

}

# Syntax
# https://developer.hashicorp.com/packer/docs/templates/hcl_templates/functions/contextual/vault
locals {
  db_user = vault("/secret/data/team00-db", "DBUSER")
}
