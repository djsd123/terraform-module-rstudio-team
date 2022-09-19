variable "name" {
  type        = string
  description = "used by some prefixes which must be no longer than 6 characters"
  default     = "rs"
}

variable "rsw" {}

variable "rsc" {}

variable "rspm" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.name
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true
}

locals {
  end_point_services = [
    "ec2messages",
    "ecr.api",
    "ecr.dkr",
    "ecs",
    "ecs-agent",
    "ecs-telemetry",
    "logs",
    "monitoring",
    "secretsmanager",
    "ssm",
    "ssmmessages"
  ]
}

resource "aws_security_group" "vpc_endpoints" {
  name        = "vpc-endpoints"
  description = "Access to Private-Link VPC endpoints"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "vpc-endpoints"
  }
}

resource "aws_security_group_rule" "vpc_endpoint_ingress_https" {
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.vpc_endpoints.id
  to_port           = 443
  type              = "ingress"
  cidr_blocks       = [module.vpc.vpc_cidr_block]
  description       = "HTTPS to Private-Link Endpoints"
}


data "aws_vpc_endpoint_service" "services" {
  for_each = toset(local.end_point_services)

  service = each.key
}

resource "aws_vpc_endpoint" "vpc_endpoints" {
  for_each = data.aws_vpc_endpoint_service.services

  service_name        = each.value.service_name
  vpc_id              = module.vpc.vpc_id
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = module.vpc.private_subnets
  security_group_ids  = [aws_security_group.vpc_endpoints.id]
}

module "rstudio_ecs_test" {
  source = "../"

  name                         = var.name
  ec2_key_pair                 = "aws_mikael"
  region                       = "eu-west-1"
  subnet_ids                   = module.vpc.private_subnets
  loadbalancer_subnet_ids      = module.vpc.public_subnets
  vpc_id                       = module.vpc.vpc_id
  security_group_id            = aws_security_group.vpc_endpoints.id
  zone_name                    = "sub.mcallison.co.uk"
  workbench_license_rsw        = var.rsw
  connect_license_rsc          = var.rsc
  package_manager_license_rspm = var.rspm
}
