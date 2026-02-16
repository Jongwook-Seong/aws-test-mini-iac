variable "vpc" {
  type = object({
    availability_zone_a = string
    availability_zone_c = string
    vpc_name            = string
    igw_name            = string
    natgw_name          = string
  })
  description = "The variables for the VPC"
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

variable "subnet" {
  type = object({
    pub_subnet_name          = string
    pri_subnet_name          = string
    pub_subnet_01_cidr_block = string
    pub_subnet_02_cidr_block = string
    pri_subnet_01_cidr_block = string
    pri_subnet_02_cidr_block = string
  })
  description = "The variables for the subnet"
}

variable "rtb" {
  type = object({
    pub_rtb_name = string
    pri_rtb_name = string
  })
  description = "The variables for the route table"
}
