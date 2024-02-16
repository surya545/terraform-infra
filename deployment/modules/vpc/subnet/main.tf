resource "aws_subnet" "main" {
  vpc_id = var.vpc_id
  for_each = {for val in var.service_definition["Resources"]["VPC"]["Subnets"]: val["Name"] => val["Properties"]}
  availability_zone = each.value.AZ
  cidr_block = each.value.CIDR
  tags = each.value.Tags
  tags_all = each.value.TagsAll
}
