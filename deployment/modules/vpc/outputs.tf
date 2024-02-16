output "vpc_id" {
  value       = aws_vpc.main.id
}

output "subnet_id" {
  value = module.subnet.*.subnet_id
}

output "routetable_id" {
  value = module.routetable.*.routetable_id
}

output "sg_id" {
  value = module.securitygroup
}

output "ingress_list" {
  value = module.securitygroup
}

output "igw_route" {
  value = module.routetable
}


output "eip_id" {
  value = module.eip
}
