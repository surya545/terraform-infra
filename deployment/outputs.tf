output "middleware_config" {
  description = "VPC Config Desc"
  value = module.microservices["api-server"].vpc_config[0].eip_id[0].eip_address.api-server-EIP
}