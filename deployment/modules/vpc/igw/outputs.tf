output "igw_id" {
  value = {for val in var.service_definition["Resources"]["VPC"]["IGW"]: val["Name"] => aws_internet_gateway.gw[val["Name"]].id }
}