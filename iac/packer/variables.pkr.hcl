variable "proxmox_api_url" {
  type    = string
  default = "https://your-proxmox-host:8006/api2/json"
}

variable "proxmox_api_token_id" {
  type    = string
  default = "packer@pam!packer"
}

variable "proxmox_api_token_secret" {
  type    = string
  default = "your-proxmox-api-token-secret"
  sensitive = true
}

variable "proxmox_node" {
  type    = string
  default = "your-proxmox-node"
} 