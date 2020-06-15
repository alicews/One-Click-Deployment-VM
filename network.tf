module "vpc" {
  source     = "git::https://github.com/cloudposse/terraform-aws-vpc.git?ref=tags/0.7.0"
  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  cidr_block = "172.16.0.0/16"
}

data "aws_availability_zones" "this" {}

module "aws_vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc"
  name   = var.name
  cidr   = "10.0.0.0/16"

  //  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  azs             = data.aws_availability_zones.this.names
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true
}

//module "subnets" {
//  source               = "git::https://github.com/cloudposse/terraform-aws-dynamic-subnets.git?ref=tags/0.16.0"
//  availability_zones   = var.availability_zones
//  namespace            = var.namespace
//  stage                = var.stage
//  name                 = var.name
//  vpc_id               = module.vpc.vpc_id
//  igw_id               = module.vpc.igw_id
//  cidr_block           = module.vpc.vpc_cidr_block
//  nat_gateway_enabled  = false
//  nat_instance_enabled = false
//}

module "aws_key_pair" {
  source              = "git::https://github.com/cloudposse/terraform-aws-key-pair.git?ref=tags/0.4.0"
  namespace           = var.namespace
  stage               = var.stage
  name                = var.name
  attributes          = ["ssh", "key"]
  ssh_public_key_path = var.ssh_public_key_path
  generate_ssh_key    = var.generate_ssh_key
}
