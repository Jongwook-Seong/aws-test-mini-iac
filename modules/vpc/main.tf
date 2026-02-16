terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = var.cidr_blocks.vpc_cidr_block
  tags = {
    Name = var.vpc.vpc_name
  }
}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = var.vpc.igw_name
  }
}

resource "aws_nat_gateway" "main_natgw" {
  allocation_id = aws_eip.main_eip[0].id
  subnet_id     = aws_subnet.pub_subnet_01.id
  tags = {
    Name = var.vpc.natgw_name
  }
}

resource "aws_eip" "main_eip" {
  count  = 2
  domain = "vpc"
}
