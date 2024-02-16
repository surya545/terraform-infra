module "vpc"{
    source = "../vpc"
    service_definition = var.service_definition
    count = can(var.service_definition.Resources.VPC) ? 1 : 0
}

module "ec2"{
    source = "../ec2"
    service_definition = var.service_definition
    vpc_config = try(module.vpc, {})
    count = can(var.service_definition.Resources.EC2) ? 1 : 0
    depends_on = [
        module.vpc
    ]
}