resource "tls_private_key" "my_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  for_each = {for val in var.service_definition["Resources"]["EC2"]: val["Name"] => val["Properties"]}
  filename = "${path.module}/../../${try(each.value.KeyName, "default-key")}"
  content  = tls_private_key.my_key.private_key_pem
}

resource "aws_key_pair" "my_key_pair" {
  for_each = {for val in var.service_definition["Resources"]["EC2"]: val["Name"] => val["Properties"]}
  key_name   = "${try(each.value.KeyName, "default-key")}"
  public_key = tls_private_key.my_key.public_key_openssh
}


resource "aws_instance" "instance" {
  for_each = {for val in var.service_definition["Resources"]["EC2"]: val["Name"] => val["Properties"]}
  ami = each.value.AMI
  instance_type = each.value.InstanceType
  key_name =  try(each.value.KeyName, "default-key")
  subnet_id = var.vpc_config[0].subnet_id[0][each.value.Subnet]
  vpc_security_group_ids = [for sg in each.value.SecurityGroup : var.vpc_config[0].sg_id[sg]["sg_id"]]
  user_data = file("${path.module}/../../scripts/${each.value.UserData}")
  tags = each.value.Tags
  tags_all = each.value.TagsAll
  depends_on = [aws_key_pair.my_key_pair]
  }

resource "aws_eip_association" "eip_assoc" {
  for_each = {for val in var.service_definition["Resources"]["EC2"]: val["Name"] => val["Properties"]}
  instance_id   = aws_instance.instance[each.key].id
  allocation_id = var.vpc_config[0].eip_id[0].eip_id[each.value.ElasticIP]
}

