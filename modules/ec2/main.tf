terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

resource "aws_key_pair" "key_pair" {
  key_name   = var.ec2.key_name
  public_key = file("${path.root}/.ssh/${var.ec2.key_name}.pub")
  tags = {
    Name = var.ec2.key_name
  }
}

# Bastion Host
resource "aws_instance" "bastion_server" {
  count           = var.ec2.is_bastion_exist ? 1 : 0
  ami             = var.instance.ami.ubuntu
  instance_type   = var.instance.instance_type
  subnet_id       = var.vpc.pub_subnet_01_id
  security_groups = [aws_security_group.bastion_sg.id]
  key_name        = aws_key_pair.key_pair.key_name
  tags = {
    Name = var.ec2.bastion_server_name
  }
}

resource "aws_eip" "bastion_eip" {
  count    = var.ec2.is_bastion_exist ? 1 : 0
  instance = aws_instance.bastion_server[count.index].id
  domain   = "vpc"
  tags = {
    Name = "${var.ec2.bastion_server_name}-eip"
  }
}

# Web Server
resource "aws_instance" "web01_server" {
  ami             = var.instance.ami.ubuntu
  instance_type   = var.instance.instance_type
  subnet_id       = var.vpc.pub_subnet_01_id
  security_groups = var.ec2.is_bastion_exist ? [aws_security_group.web_sg.id, aws_security_group.ssh_sg.id] : [aws_security_group.web_sg.id, aws_security_group.ssh_sg.id, aws_security_group.bastion_sg.id]
  key_name        = aws_key_pair.key_pair.key_name
  tags = {
    Name = var.ec2.web01_server_name
  }
}

resource "aws_eip" "web_as_bastion_eip" {
  count    = var.ec2.is_bastion_exist ? 0 : 1
  instance = aws_instance.web01_server.id
  domain   = "vpc"
  tags = {
    Name = "${var.ec2.web01_server_name}-as-bastion-eip"
  }
}

# WAS Server
resource "aws_instance" "was01_server" {
  ami             = var.instance.ami.ubuntu
  instance_type   = var.instance.instance_type
  subnet_id       = var.vpc.pri_subnet_01_id
  security_groups = [aws_security_group.was_sg.id, aws_security_group.ssh_sg.id]
  key_name        = aws_key_pair.key_pair.key_name
  tags = {
    Name = var.ec2.was01_server_name
  }
}
