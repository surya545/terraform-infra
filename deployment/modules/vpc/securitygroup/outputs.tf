# output "sg_id" {
#   value = {for val in var.service_definition["Resources"]["VPC"]["SecurityGroup"]: val["Name"] => aws_security_group.sg.id }
# }



output "sg_id" {
  value = aws_security_group.sg.id
}