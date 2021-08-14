variable location {
  default = "eastus"
}

variable "prefix" {
  description = "A prefix used for all resources in this example"
  default = "aksdemo"
}
variable "ssh_public_key" {
  default = "./.ssh/id_rsa.pub"
  description = "This variable defines the SSH Public Key for Linux k8s Worker nodes"  
}

