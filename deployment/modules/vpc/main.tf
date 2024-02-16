resource "aws_vpc" "main" {
  cidr_block = var.service_definition.Resources.VPC.CIDR
}

module "subnet" {
    source = "./subnet"
    service_definition = var.service_definition
    vpc_id = aws_vpc.main.id
    count = can(var.service_definition.Resources.VPC.Subnets) ? 1 : 0
}

module "routetable" {
    source = "./routetable"
    service_definition = var.service_definition
    vpc_id = aws_vpc.main.id
    subnet_association_id = try(module.subnet, "")
    igw_association_id = try(module.igw, "")
    count = can(var.service_definition.Resources.VPC.RouteTables) ? 1 : 0
}

module "igw" {
    source = "./igw"
    service_definition = var.service_definition
    vpc_id = aws_vpc.main.id
    count = can(var.service_definition.Resources.VPC.IGW) ? 1 : 0
}

module "securitygroup" {
    for_each = try({ for val in var.service_definition.Resources.VPC.SecurityGroup: val["Name"] => val }, {})
    source = "./securitygroup"
    service_definition = var.service_definition
    sg_definition = each.value
    vpc_id = aws_vpc.main.id
}


module "eip" {
    source = "./eip"
    service_definition = var.service_definition
    count = can(var.service_definition.Resources.VPC.EIP) ? 1 : 0
}
