variable "vm_ami"{
    description = "used ami by vm"
}

variable "vm_instance_type"{
    description = "used type of instance"
}

variable "vm_instance_name"{
    description = "vm name"
}

variable "vm_subnet_id"{
    description = "belonging to subnet"
}

variable "vm_private_ip"{
    description = "vm private ip"
}

variable "eip_gw"{
    description = "definition of gateway for vm ip"
}

variable "subnet_address" {
    description = "subnet scope for security group"
}

variable "sg_id" {
    description = "definition of sg attached to vm"
}