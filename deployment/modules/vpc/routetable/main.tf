resource "aws_route_table" "route" {
  vpc_id = var.vpc_id
  for_each = {for val in var.service_definition["Resources"]["VPC"]["RouteTables"]: val["Name"] => val["Properties"]}
  dynamic "route" {
    for_each = can(each.value.Associations.IGW) ? [1] : []
    content {
      cidr_block = "0.0.0.0/0"
      gateway_id = can(each.value.Associations.IGW) ? var.igw_association_id[0]["igw_id"][local.list2[0]] : null
    }
  }
  tags = each.value.Tags
}

resource "aws_route_table_association" "association" {
  for_each = {for val in local.list1: val["value_name"] => val["key_name"]}
  subnet_id = var.subnet_association_id[0]["subnet_id"][each.key]
  route_table_id = aws_route_table.route[each.value].id
}

locals {
  associationlist = {for val in var.service_definition["Resources"]["VPC"]["RouteTables"]: val["Name"] => val["Properties"]["Associations"]["Subnets"] }
  list1 = flatten([for key, value in local.associationlist: [
    for v in value:{
      key_name = key
      value_name = v
    }
  ]
  ])
}

locals {
  igw_associationlist = [
    for val in var.service_definition["Resources"]["VPC"]["RouteTables"] : 
    can(val["Properties"]["Associations"]["IGW"]) ? val["Properties"]["Associations"]["IGW"][0] : null 
  ]
  list2 = [for val in local.igw_associationlist : val if val != null]
}
