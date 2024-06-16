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
  default     = "a2438706-bf58-49a1-aa18-fe91037387c4"
}

variable "flavor_id" {
  description = "The ID of the flavor to use for the instance"
  default     = "b6b7baeb-2328-48c9-8543-88cccec8ec4b"
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