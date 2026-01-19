variable "memory_amount" {
  type =  string
  default = "4096"
}

variable "SSHPW" {
  # Don't hard code a password here...
  sensitive = true
  type = string
  default = ""
}

variable "build_artifact_location" {
  type = string
  default = "../build/"
}
