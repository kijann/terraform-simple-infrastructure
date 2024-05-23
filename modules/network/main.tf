resource "aws_vpc" "main"{
    cidr_block = var.vpc_network_address
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = var.vpc_name
    }
}

resource "aws_subnet" "public"{
    vpc_id = aws_vpc.main.id
    cidr_block = var.subnet_address
    tags = {
        Name = var.subnet_name
    }
}

data "aws_availability_zones" "available_zones" {
    state = "available"
}

resource "aws_subnet" "public_db_1"{
    vpc_id = aws_vpc.main.id
    cidr_block = var.subnet_db1_address
    availability_zone = data.aws_availability_zones.available_zones.names[0]
    tags = {
        Name = var.subnet_db1_name
    }
}


resource "aws_subnet" "public_db_2"{
    vpc_id = aws_vpc.main.id
    cidr_block = var.subnet_db2_address
    availability_zone = data.aws_availability_zones.available_zones.names[1]
    tags = {
        Name = var.subnet_db2_name
    }
}

resource "aws_db_subnet_group" "main" {
    name = "database-subnets"
    subnet_ids = [aws_subnet.public_db_1.id, aws_subnet.public_db_2.id] 
    tags = {
        Name = "subnet_group_db"
    }
}

resource "aws_internet_gateway" "main"{
    vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "main"{
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id=aws_internet_gateway.main.id
    }    
    route {
        ipv6_cidr_block = "::/0"
        gateway_id = aws_internet_gateway.main.id
    }
}

resource "aws_route_table_association" "association"{
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "association_db_1"{
    subnet_id = aws_subnet.public_db_1.id
    route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "association_db_2"{
    subnet_id = aws_subnet.public_db_2.id
    route_table_id = aws_route_table.main.id
}

output "subnet_id" {
  value = aws_subnet.public.id
}

output "subnet_address" {
    value = aws_subnet.public.cidr_block
}

output "gw" {
  value = aws_internet_gateway.main
}

output "vpc_id"{
    value = aws_vpc.main.id
}

output "db_subnets_group_name" {
    value = aws_db_subnet_group.main.name
}

output "available_zone_for_db" {
    value = data.aws_availability_zones.available_zones.names[0]
}