output "routetable_id" {
  value = {for val in var.service_definition["Resources"]["VPC"]["RouteTables"]: val["Name"] => aws_route_table.route[val["Name"]].id }
}


output "test1" {
  value = local.list2
}