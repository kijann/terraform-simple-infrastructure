variable "username" {
    description = "db password"
    type = string
}
variable "password" {
    description = "db password"
    type = string
    sensitive   = true
}
variable "db_subnet_group_name" {
    description = "db subnet group name"
}

variable "sg_id" {
    description = "db security group id"
}

variable "available_zone" {
    description = "availabler zone for db"
}