variable "os_user_name" {
  description = "The OpenStack username."
  type        = string
}

variable "os_user_domain_name" {
  description = "The OpenStack domain name."
  type        = string
}

variable "os_tenant_name" {
  description = "The OpenStack tenant name."
  type        = string
}

variable "os_password" {
  description = "The OpenStack password."
  type        = string
  sensitive   = true
}

variable "os_auth_url" {
  description = "The OpenStack authentication URL."
  type        = string
}

variable "os_region_name" {
  description = "The OpenStack region name."
  type        = string
}

variable "name" {
  description = "The name of the instance"
  default     = "instance-chatbot"
}

variable "image_id" {
  description = "The ID of the image to use for the instance"
#   default     = "a6b1aabf-c9e0-4506-a5f7-b3884bf32903" # Debian 10
  default	 = "a8cbc080-d83d-4817-8bbb-e61f37f2c28e" # Ubuntu 22.04 LTS Jammy Jellyfish
}

variable "flavor_id" {
  description = "The ID of the flavor to use for the instance"
#   default     = "b6b7baeb-2328-48c9-8543-88cccec8ec4b" # = 2 vCPU, 4GB RAM, 20GB Disk
  default	 = "67012020-b4cf-4b34-a91d-c55ae68c48cb" # = 4 vCPU, 16GB RAM, 20GB Disk
#   default	 = "e1fefc6e-5c1c-4cae-9a18-d4606bc7d431" # = 4 vCPU, 16GB RAM, 50GB Disk
}

variable "network_id" {
  description = "The ID of the network to attach the instance to"
  default     = "dcf25c41-9057-4bc2-8475-a2e3c5d8c662"
}

variable "network_name" {
  description = "The name of the network to attach the instance to"
  default     = "ext-net1"
}

variable "username" {
  description = "The name of the user to use for SSH"
  default     = "ubuntu"
}

variable "public_key" {
  description = "Public SSH key"
  type        = string
}