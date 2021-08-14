variable subscription_id {
  description = "This is the Subscription ID for your azure account"
  type = string
}

variable client_id {
  description = "This is the Client ID of your managed system identity"
  type = string
}

variable client_secret {
  description = "This is the Client secret of your managed system identity"
  type = string
}

variable tenant_id {
  description = "This is the tenant ID of your managed system identity"
  type = string
}

variable location {
  default = "eastus"
}

variable "prefix" {
  description = "A prefix used for all resources in this example"
  default = "akscalico"
}
variable "ssh_public_key" {
  default = "./.ssh/id_rsa.pub"
  description = "This variable defines the SSH Public Key for Linux k8s Worker nodes"  
}

