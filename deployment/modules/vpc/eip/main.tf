resource "aws_eip" "eip" {
  for_each = {for val in var.service_definition["Resources"]["VPC"]["EIP"]: val["Name"] => val["Properties"]}
  public_ipv4_pool = "amazon"
  tags              = each.value.Tags 
  tags_all          = each.value.TagsAll
}