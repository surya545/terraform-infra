resource "aws_security_group" "sg" {
  name        = var.sg_definition.Name
  description = var.sg_definition.Properties.Description
  vpc_id      = var.vpc_id
  dynamic "egress"{
    for_each = try(var.sg_definition.Properties.Egress, {})
    content {
        from_port        = egress.value.From
        to_port          = egress.value.To
        protocol         = "-1"
        cidr_blocks      = egress.value.CIDR
        ipv6_cidr_blocks = []
        prefix_list_ids  = []
        security_groups  = []
        self             = false
    }
  }
  dynamic "ingress" {
    for_each = try(var.sg_definition.Properties.Ingress, {})
    content {
      from_port        = ingress.value.From
      to_port          = ingress.value.To
      protocol         = try(ingress.value.Protocol, "-1")
      cidr_blocks      = ingress.value.CIDR
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  }
  tags = var.sg_definition.Properties.Tags
  tags_all = var.sg_definition.Properties.TagsAll
}

