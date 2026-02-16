variable "access_key" {
  type        = string
  description = "The access key for the AWS account"
}

variable "secret_key" {
  type        = string
  description = "The secret key for the AWS account"
}

variable "region" {
  type        = string
  description = "The region of the AWS account"
}

variable "availability_zone" {
  type        = string
  description = "The availability zone of the subnet"
}

variable "key_name" {
  type        = string
  description = "The name of the key pair"
}

variable "resource_name_prefix" {
  type        = string
  description = "The prefix of the resource name"
}

variable "vpc_cidr_block" {
  type        = string
  description = "The CIDR block of the VPC"
}

variable "my_public_ip_cidr_block" {
  type        = string
  description = "The CIDR block of the my public IP"
}

variable "ubuntu_ami" {
  type        = string
  description = "The AMI of the Ubuntu"
}

variable "ubuntu_instance_type" {
  type        = string
  description = "The instance type of the Ubuntu"
}

variable "is_bastion_exist" {
  type        = bool
  description = "Whether the bastion server exists"
}