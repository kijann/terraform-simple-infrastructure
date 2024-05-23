provider "aws" {
  region = "us-east-1"
}

module "cicd" {
  source           = "./modules/vm"
  vm_ami           = "ami-0c7217cdde317cfec"
  vm_instance_type = "t2.micro"
  vm_instance_name = "cicd"

  vm_subnet_id   = module.network.subnet_id
  vm_private_ip  = var.cicd_private_ip
  eip_gw         = module.network.gw
  subnet_address = module.network.subnet_address
  sg_id          = module.security_groups.sg_cicd_id
}

module "app" {
  source           = "./modules/vm"
  vm_ami           = "ami-0c7217cdde317cfec"
  vm_instance_type = "t2.micro"
  vm_instance_name = "app"

  vm_subnet_id   = module.network.subnet_id
  vm_private_ip  = var.app_private_ip
  eip_gw         = module.network.gw
  subnet_address = module.network.subnet_address
  sg_id          = module.security_groups.sg_app_id
}

module "db" {
  source               = "./modules/db"
  db_subnet_group_name = module.network.db_subnets_group_name
  sg_id                = module.security_groups.sg_db_id
  available_zone       = module.network.available_zone_for_db


  username = var.username
  password = var.password
}

module "network" {
  source = "./modules/network"

  vpc_name            = "vpc prod"
  vpc_network_address = var.network_address

  subnet_name    = "subnet app"
  subnet_address = var.subnet_address

  subnet_db1_name    = "subnet db first"
  subnet_db1_address = var.subnet_db1_address

  subnet_db2_name    = "subnet db second"
  subnet_db2_address = var.subnet_db2_address
}

module "security_groups" {
  source             = "./modules/security-group"
  sg_vpc_id          = module.network.vpc_id
  subnet_address     = module.network.subnet_address
  db_ingress_rule_ip = module.app.private_ip
}