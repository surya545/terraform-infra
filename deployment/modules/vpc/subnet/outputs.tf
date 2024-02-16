output "subnet_id" {
  value = {for val in var.service_definition["Resources"]["VPC"]["Subnets"]: val["Name"] => aws_subnet.main[val["Name"]].id }
}