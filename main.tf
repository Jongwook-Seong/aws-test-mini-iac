terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

module "vpc" {
  source      = "./modules/vpc"
  vpc         = local.vpc
  cidr_blocks = local.cidr_blocks
  subnet      = local.subnet
  rtb         = local.rtb
}

module "ec2" {
  source      = "./modules/ec2"
  vpc_id      = module.vpc.vpc_id
  vpc         = module.vpc
  instance    = local.instance
  cidr_blocks = local.cidr_blocks
  ec2         = local.ec2
  sg          = local.sg
  elb         = local.elb

  depends_on = [module.vpc]
}