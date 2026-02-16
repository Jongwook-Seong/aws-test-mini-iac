variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "vpc" {
  type = object({
    vpc_id           = string
    pub_subnet_01_id = string
    pub_subnet_02_id = string
    pri_subnet_01_id = string
    pri_subnet_02_id = string
  })
  description = "The variables for the VPC"
}

variable "instance" {
  type = object({
    ami = object({
      ubuntu = string
    })
    instance_type = string
  })
  description = "The variables for the instance"
}

variable "cidr_blocks" {
  type = object({
    any_ip_cidr_block        = string
    my_public_ip_cidr_block  = string
    vpc_cidr_block           = string
    pub_subnet_01_cidr_block = string
    pub_subnet_02_cidr_block = string
    pri_subnet_01_cidr_block = string
    pri_subnet_02_cidr_block = string
  })
  description = "The variables for the CIDR blocks"
}

variable "ec2" {
  type = object({
    is_bastion_exist    = bool
    key_name            = string
    bastion_server_name = string
    web01_server_name   = string
    web02_server_name   = string
    was01_server_name   = string
    was02_server_name   = string
  })
  description = "The variables for the EC2"
}

variable "sg" {
  type = object({
    is_bastion_exist = bool
    bastion_sg_name  = string
    web_sg_name      = string
    was_sg_name      = string
    ssh_sg_name      = string
    alb_sg_name      = string
    nlb_sg_name      = string
  })
  description = "The variables for the security group"
}

variable "elb" {
  type = object({
    alb_name            = string
    alb_listener_name   = string
    alb_tg_name         = string
    nlb_name            = string
    nlb_listener_name   = string
    nlb_tg_name         = string
    availability_zone_a = string
    availability_zone_c = string
  })
  description = "The variables for the ELB"
}
