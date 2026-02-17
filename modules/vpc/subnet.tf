resource "aws_subnet" "pub_subnet_01" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.cidr_blocks.pub_subnet_01_cidr_block
  availability_zone = var.vpc.availability_zone_a
  tags = {
    Name = "${var.subnet.pub_subnet_name}-01"
  }
}

resource "aws_subnet" "pub_subnet_02" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.cidr_blocks.pub_subnet_02_cidr_block
  availability_zone = var.vpc.availability_zone_c
  tags = {
    Name = "${var.subnet.pub_subnet_name}-02"
  }
}

resource "aws_subnet" "pri_subnet_01" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.cidr_blocks.pri_subnet_01_cidr_block
  availability_zone = var.vpc.availability_zone_a
  tags = {
    Name = "${var.subnet.pri_subnet_name}-01"
  }
}

resource "aws_subnet" "pri_subnet_02" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.cidr_blocks.pri_subnet_02_cidr_block
  availability_zone = var.vpc.availability_zone_c
  tags = {
    Name = "${var.subnet.pri_subnet_name}-02"
  }
}

resource "aws_route_table" "pub_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = var.cidr_blocks.any_ip_cidr_block
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = var.rtb.pub_rtb_name
  }
}

resource "aws_route_table_association" "pub_01_route_table_association" {
  subnet_id      = aws_subnet.pub_subnet_01.id
  route_table_id = aws_route_table.pub_route_table.id
}

resource "aws_route_table_association" "pub_02_route_table_association" {
  subnet_id      = aws_subnet.pub_subnet_02.id
  route_table_id = aws_route_table.pub_route_table.id
}

resource "aws_route_table" "pri_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = var.cidr_blocks.any_ip_cidr_block
    gateway_id = aws_nat_gateway.main_natgw.id
  }

  tags = {
    Name = var.rtb.pri_rtb_name
  }
}

resource "aws_route_table_association" "pri_01_route_table_association" {
  subnet_id      = aws_subnet.pri_subnet_01.id
  route_table_id = aws_route_table.pri_route_table.id
}

resource "aws_route_table_association" "pri_02_route_table_association" {
  subnet_id      = aws_subnet.pri_subnet_02.id
  route_table_id = aws_route_table.pri_route_table.id
}