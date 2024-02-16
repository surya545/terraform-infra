resource "aws_internet_gateway" "gw" {
  vpc_id = var.vpc_id
  for_each = {for val in var.service_definition["Resources"]["VPC"]["IGW"]: val["Name"] => val["Properties"]}
  tags = each.value.Tags
  tags_all = each.value.TagsAll
}