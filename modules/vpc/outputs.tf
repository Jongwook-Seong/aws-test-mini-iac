output "vpc_id" {
  value = aws_vpc.main_vpc.id
  description = "The ID of the VPC"
}

output "igw_id" {
  value = aws_internet_gateway.main_igw.id
  description = "The ID of the Internet Gateway"
}

output "natgw_id" {
  value = aws_nat_gateway.main_natgw.id
  description = "The ID of the NAT Gateway"
}

output "pub_subnet_id" {
  value = aws_subnet.pub_subnet.id
  description = "The ID of the public subnet"
}

output "pri_subnet_id" {
  value = aws_subnet.pri_subnet.id
  description = "The ID of the private subnet"
}