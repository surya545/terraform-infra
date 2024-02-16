output "eip_id" {
  value = {for val in var.service_definition["Resources"]["VPC"]["EIP"]: val["Name"] => aws_eip.eip[val["Name"]].id }
}

output "eip_address" {
  value = {for val in var.service_definition["Resources"]["VPC"]["EIP"]: val["Name"] => aws_eip.eip[val["Name"]].public_ip}
}