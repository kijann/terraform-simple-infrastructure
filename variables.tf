//ip adresses
variable "network_address" {
  description = "vpc network address"
  default     = "10.0.0.0/16"
}

variable "subnet_address" {
  description = "subnet network address"
  default     = "10.0.1.0/24"
}

variable "subnet_db1_address" {
  description = "subnet network address"
  default     = "10.0.2.0/24"
}

variable "subnet_db2_address" {
  description = "subnet network address"
  default     = "10.0.3.0/24"
}
//
variable "cicd_private_ip" {
  description = "kubernetes vm ip"
  default     = "10.0.1.20"
}

variable "app_private_ip" {
  description = "app vm ip"
  default     = "10.0.1.30"
}

variable "password" {
  description = "db password"
  type        = string
  sensitive   = true
}

variable "username" {
  description = "db username"
  type        = string
}

// security groups


