variable "memory_amount" {
  type =  string
  default = "4096"
}

variable "SSHPW" {
  sensitive = true
  type = string
  default = "vagrant"
}

variable "build_artifact_location" {
  type = string
  default = "../build/"
}
