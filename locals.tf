locals {
  vpc_name   = "${var.resource_name_prefix}-vpc"
  igw_name   = "${var.resource_name_prefix}-igw"
  natgw_name = "${var.resource_name_prefix}-natgw"

  pub_subnet_name = "${var.resource_name_prefix}-pub-subnet"
  pri_subnet_name = "${var.resource_name_prefix}-pri-subnet"
  pub_rtb_name    = "${var.resource_name_prefix}-pub-rtb"
  pri_rtb_name    = "${var.resource_name_prefix}-pri-rtb"

  bastion_server_name = "${var.resource_name_prefix}-bastion-server"
  web_server_name     = "${var.resource_name_prefix}-web-server"
  was_server_name     = "${var.resource_name_prefix}-was-server"
  bastion_sg_name     = "${var.resource_name_prefix}-bastion-sg"

  web_sg_name = "${var.resource_name_prefix}-web-sg"
  was_sg_name = "${var.resource_name_prefix}-was-sg"
  ssh_sg_name = "${var.resource_name_prefix}-ssh-sg"
  alb_sg_name = "${var.resource_name_prefix}-alb-sg"
  nlb_sg_name = "${var.resource_name_prefix}-nlb-sg"

  alb_name          = "${var.resource_name_prefix}-alb"
  alb_listener_name = "${var.resource_name_prefix}-alb-listener"
  alb_tg_name       = "${var.resource_name_prefix}-alb-tg"

  nlb_name          = "${var.resource_name_prefix}-nlb"
  nlb_listener_name = "${var.resource_name_prefix}-nlb-listener"
  nlb_tg_name       = "${var.resource_name_prefix}-nlb-tg"

  pub_subnet_cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 0)
  pri_subnet_cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 1)

  any_ip_cidr_block = "0.0.0.0/0"

  vpc = {
    availability_zone = var.availability_zone
    vpc_name          = local.vpc_name
    igw_name          = local.igw_name
    natgw_name        = local.natgw_name
  }

  subnet = {
    pub_subnet_name       = local.pub_subnet_name
    pri_subnet_name       = local.pri_subnet_name
    pub_subnet_cidr_block = local.pub_subnet_cidr_block
    pri_subnet_cidr_block = local.pri_subnet_cidr_block
  }

  rtb = {
    pub_rtb_name = local.pub_rtb_name
    pri_rtb_name = local.pri_rtb_name
  }

  cidr_blocks = {
    any_ip_cidr_block       = local.any_ip_cidr_block
    my_public_ip_cidr_block = var.my_public_ip_cidr_block
    vpc_cidr_block          = var.vpc_cidr_block
    pub_subnet_cidr_block   = local.pub_subnet_cidr_block
    pri_subnet_cidr_block   = local.pri_subnet_cidr_block
  }

  instance = {
    ami = {
      ubuntu = var.ubuntu_ami
    }
    instance_type = var.ubuntu_instance_type
  }

  ec2 = {
    is_bastion_exist    = var.is_bastion_exist
    key_name            = var.key_name
    bastion_server_name = local.bastion_server_name
    web_server_name     = local.web_server_name
    was_server_name     = local.was_server_name
  }

  sg = {
    is_bastion_exist = var.is_bastion_exist
    bastion_sg_name  = local.bastion_sg_name
    web_sg_name      = local.web_sg_name
    was_sg_name      = local.was_sg_name
    ssh_sg_name      = local.ssh_sg_name
    alb_sg_name      = local.alb_sg_name
    nlb_sg_name      = local.nlb_sg_name
  }

  elb = {
    alb_name          = local.alb_name
    alb_listener_name = local.alb_listener_name
    alb_tg_name       = local.alb_tg_name
    nlb_name          = local.nlb_name
    nlb_listener_name = local.nlb_listener_name
    nlb_tg_name       = local.nlb_tg_name
    availability_zone = var.availability_zone
  }
}
