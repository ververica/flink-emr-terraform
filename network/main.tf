# Variables

variable "region" {
  type    = string
  default = "eu-central-1"
}
variable "tags" {}

#
# Creates a VPC with two public subnets.
#
module "vpc" {
  source                  = "terraform-aws-modules/vpc/aws"
  name                    = "core"
  cidr                    = "10.0.0.0/16"
  azs                     = [lookup(var.av_zone_a, var.region), lookup(var.av_zone_b, var.region)]
  public_subnets          = ["10.0.0.0/24", "10.0.2.0/24"]
  enable_dns_support      = true
  enable_dns_hostnames    = true
  enable_nat_gateway      = false
  map_public_ip_on_launch = true
  tags                    = var.tags
}

# Creates security groups:
#
# - Additional integration security group that has open traffic between itself.
#   This can be then used for anohter service with additional settings if required.

#
# A security group for other integration services such as EMR, Managed
# Flink cluster, or others.
#
resource "aws_security_group" "integration_service_security_group" {
  name        = "integration-service-security-group"
  description = "Allow inbound traffic, used for an services to test."
  vpc_id      = module.vpc.vpc_id
  tags        = var.tags
}

# Outputs

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_1" {
  value = module.vpc.public_subnets[0]
}

output "public_subnet_2" {
  value = module.vpc.public_subnets[1]
}

output "integration_service_security_group_id" {
  value = aws_security_group.integration_service_security_group.id
}
