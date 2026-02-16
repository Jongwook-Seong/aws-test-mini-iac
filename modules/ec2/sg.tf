# Bastion Security Group
resource "aws_security_group" "bastion_sg" {
  name   = var.sg.bastion_sg_name
  vpc_id = var.vpc.vpc_id

  tags = {
    Name = var.sg.bastion_sg_name
  }
}

resource "aws_security_group_rule" "bastion_sg_ingress_rule_ssh_my_public_ip" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.cidr_blocks.my_public_ip_cidr_block]
  security_group_id = aws_security_group.bastion_sg.id
}

resource "aws_security_group_rule" "bastion_sg_egress_rule" {
  type              = "egress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.cidr_blocks.vpc_cidr_block]
  security_group_id = aws_security_group.bastion_sg.id
}

resource "aws_security_group_rule" "bastion_sg_egress_rule_icmp" {
  type              = "egress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = [var.cidr_blocks.vpc_cidr_block]
  security_group_id = aws_security_group.bastion_sg.id
}

# Web Security Group
resource "aws_security_group" "web_sg" {
  name   = var.sg.web_sg_name
  vpc_id = var.vpc.vpc_id

  tags = {
    Name = var.sg.web_sg_name
  }
}

# Web Security Group - Ingress Rule for 80 (HTTP)
resource "aws_security_group_rule" "web_sg_ingress_rule_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [var.cidr_blocks.any_ip_cidr_block]
  security_group_id = aws_security_group.web_sg.id
}

# Web Security Group - Ingress Rule for 80 (HTTP) from ALB Health Check
resource "aws_security_group_rule" "web_sg_ingress_rule_http_from_alb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb_sg.id
  security_group_id        = aws_security_group.web_sg.id
}

# Web Security Group - Ingress Rule for 443 (HTTPS)
resource "aws_security_group_rule" "web_sg_ingress_rule_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [var.cidr_blocks.any_ip_cidr_block]
  security_group_id = aws_security_group.web_sg.id
}

# Web Security Group - Ingress Rule for 443 (HTTPS) from ALB Health Check
resource "aws_security_group_rule" "web_sg_ingress_rule_https_from_alb" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb_sg.id
  security_group_id        = aws_security_group.web_sg.id
}

# Web Security Group - Ingress Rule for 8080 (Jenkins)
resource "aws_security_group_rule" "web_sg_ingress_rule_8080" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = [var.cidr_blocks.my_public_ip_cidr_block]
  security_group_id = aws_security_group.web_sg.id
}

# Web Security Group - Ingress Rule for 8080 (Jenkins) from ALB Health Check
resource "aws_security_group_rule" "web_sg_ingress_rule_8080_from_alb" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb_sg.id
  security_group_id        = aws_security_group.web_sg.id
}

# Web Security Group - Ingress Rule for 8929 (GitLab)
resource "aws_security_group_rule" "web_sg_ingress_rule_8929" {
  type              = "ingress"
  from_port         = 8929
  to_port           = 8929
  protocol          = "tcp"
  cidr_blocks       = [var.cidr_blocks.my_public_ip_cidr_block]
  security_group_id = aws_security_group.web_sg.id
}

# Web Security Group - Ingress Rule for 8929 (GitLab) from ALB Health Check
resource "aws_security_group_rule" "web_sg_ingress_rule_8929_from_alb" {
  type                     = "ingress"
  from_port                = 8929
  to_port                  = 8929
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb_sg.id
  security_group_id        = aws_security_group.web_sg.id
}

resource "aws_security_group_rule" "web_sg_egress_rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [var.cidr_blocks.any_ip_cidr_block]
  security_group_id = aws_security_group.web_sg.id
}

resource "aws_security_group_rule" "web_sg_egress_rule_8019_to_was" {
  type                     = "egress"
  from_port                = 8019
  to_port                  = 8019
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.was_sg.id
  security_group_id        = aws_security_group.web_sg.id
}

resource "aws_security_group_rule" "web_sg_egress_rule_8080_to_was" {
  type                     = "egress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.was_sg.id
  security_group_id        = aws_security_group.web_sg.id
}

resource "aws_security_group_rule" "web_sg_egress_rule_8929_to_was" {
  type                     = "egress"
  from_port                = 8929
  to_port                  = 8929
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.was_sg.id
  security_group_id        = aws_security_group.web_sg.id
}

resource "aws_security_group_rule" "web_sg_egress_rule_8019_to_nlb" {
  type                     = "egress"
  from_port                = 8019
  to_port                  = 8019
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.nlb_sg.id
  security_group_id        = aws_security_group.web_sg.id
}

resource "aws_security_group_rule" "web_sg_egress_rule_8080_to_nlb" {
  type                     = "egress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.nlb_sg.id
  security_group_id        = aws_security_group.web_sg.id
}

resource "aws_security_group_rule" "web_sg_egress_rule_8929_to_nlb" {
  type                     = "egress"
  from_port                = 8929
  to_port                  = 8929
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.nlb_sg.id
  security_group_id        = aws_security_group.web_sg.id
}

# WAS Security Group
resource "aws_security_group" "was_sg" {
  name   = var.sg.was_sg_name
  vpc_id = var.vpc.vpc_id

  tags = {
    Name = var.sg.was_sg_name
  }
}

resource "aws_security_group_rule" "was_sg_ingress_rule_icmp" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = [var.cidr_blocks.vpc_cidr_block]
  security_group_id = aws_security_group.was_sg.id
}

# WAS Security Group - Ingress Rule for 8019 (Service) from Web Security Group
resource "aws_security_group_rule" "was_sg_ingress_rule_8019_from_web" {
  type                     = "ingress"
  from_port                = 8019
  to_port                  = 8019
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web_sg.id
  security_group_id        = aws_security_group.was_sg.id
}

# WAS Security Group - Ingress Rule for 8019 (Service) from NLB Security Group
resource "aws_security_group_rule" "was_sg_ingress_rule_8019_from_nlb" {
  type                     = "ingress"
  from_port                = 8019
  to_port                  = 8019
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.nlb_sg.id
  security_group_id        = aws_security_group.was_sg.id
}

# WAS Security Group - Ingress Rule for 8080 (Jenkins) from Web Security Group
resource "aws_security_group_rule" "was_sg_ingress_rule_8080_from_web" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web_sg.id
  security_group_id        = aws_security_group.was_sg.id
}

# WAS Security Group - Ingress Rule for 8080 (Jenkins) from NLB Security Group
resource "aws_security_group_rule" "was_sg_ingress_rule_8080_from_nlb" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.nlb_sg.id
  security_group_id        = aws_security_group.was_sg.id
}

# WAS Security Group - Ingress Rule for 8929 (GitLab) from Web Security Group
resource "aws_security_group_rule" "was_sg_ingress_rule_8929_from_web" {
  type                     = "ingress"
  from_port                = 8929
  to_port                  = 8929
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web_sg.id
  security_group_id        = aws_security_group.was_sg.id
}

# WAS Security Group - Ingress Rule for 8929 (GitLab) from NLB Security Group
resource "aws_security_group_rule" "was_sg_ingress_rule_8929_from_nlb" {
  type                     = "ingress"
  from_port                = 8929
  to_port                  = 8929
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.nlb_sg.id
  security_group_id        = aws_security_group.was_sg.id
}

# WAS Security Group - Egress Rule for ICMP
resource "aws_security_group_rule" "was_sg_egress_rule_icmp" {
  type              = "egress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = [var.cidr_blocks.pub_subnet_cidr_block]
  security_group_id = aws_security_group.was_sg.id
}

# WAS Security Group - Egress Rule for Any
resource "aws_security_group_rule" "was_sg_egress_rule_any" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [var.cidr_blocks.any_ip_cidr_block]
  security_group_id = aws_security_group.was_sg.id
}

# SSH Security Group
resource "aws_security_group" "ssh_sg" {
  name   = var.sg.ssh_sg_name
  vpc_id = var.vpc.vpc_id

  tags = {
    Name = var.sg.ssh_sg_name
  }
}

# SSH Security Group - Ingress Rule for SSH from My Public IP
resource "aws_security_group_rule" "ssh_sg_ingress_rule_ssh_my_public_ip" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.cidr_blocks.my_public_ip_cidr_block]
  security_group_id = aws_security_group.ssh_sg.id
}

# SSH Security Group - Ingress Rule for SSH from Bastion Security Group
resource "aws_security_group_rule" "ssh_sg_ingress_rule_ssh_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion_sg.id
  security_group_id        = aws_security_group.ssh_sg.id
}

# SSH Security Group - Egress Rule for SSH to VPC
resource "aws_security_group_rule" "ssh_sg_egress_rule" {
  type              = "egress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.cidr_blocks.vpc_cidr_block]
  security_group_id = aws_security_group.ssh_sg.id
}

# ALB Security Group
resource "aws_security_group" "alb_sg" {
  name   = var.sg.alb_sg_name
  vpc_id = var.vpc.vpc_id

  tags = {
    Name = var.sg.alb_sg_name
  }
}

# ALB Security Group - Ingress Rule for 80 (HTTP)
resource "aws_security_group_rule" "alb_sg_ingress_rule_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [var.cidr_blocks.any_ip_cidr_block]
  security_group_id = aws_security_group.alb_sg.id
}

# ALB Security Group - Ingress Rule for 443 (HTTPS)
resource "aws_security_group_rule" "alb_sg_ingress_rule_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [var.cidr_blocks.any_ip_cidr_block]
  security_group_id = aws_security_group.alb_sg.id
}

# ALB Security Group - Ingress Rule for 8080 (Jenkins)
resource "aws_security_group_rule" "alb_sg_ingress_rule_8080" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = [var.cidr_blocks.my_public_ip_cidr_block]
  security_group_id = aws_security_group.alb_sg.id
}

# ALB Security Group - Ingress Rule for 8929 (GitLab)
resource "aws_security_group_rule" "alb_sg_ingress_rule_8929" {
  type              = "ingress"
  from_port         = 8929
  to_port           = 8929
  protocol          = "tcp"
  cidr_blocks       = [var.cidr_blocks.my_public_ip_cidr_block]
  security_group_id = aws_security_group.alb_sg.id
}

# ALB Security Group - Egress Rule for 80 (HTTP) to Web Security Group Health Check
resource "aws_security_group_rule" "alb_sg_egress_rule_80" {
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web_sg.id
  security_group_id        = aws_security_group.alb_sg.id
}

# ALB Security Group - Egress Rule for 443 (HTTPS) to Web Security Group Health Check
resource "aws_security_group_rule" "alb_sg_egress_rule_443" {
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web_sg.id
  security_group_id        = aws_security_group.alb_sg.id
}

# ALB Security Group - Egress Rule for 8080 (Jenkins) to Web Security Group Health Check
resource "aws_security_group_rule" "alb_sg_egress_rule_8080" {
  type                     = "egress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web_sg.id
  security_group_id        = aws_security_group.alb_sg.id
}

# ALB Security Group - Egress Rule for 8929 (GitLab) to Web Security Group Health Check
resource "aws_security_group_rule" "alb_sg_egress_rule_8929" {
  type                     = "egress"
  from_port                = 8929
  to_port                  = 8929
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web_sg.id
  security_group_id        = aws_security_group.alb_sg.id
}

# NLB Security Group
resource "aws_security_group" "nlb_sg" {
  name   = var.sg.nlb_sg_name
  vpc_id = var.vpc.vpc_id

  tags = {
    Name = var.sg.nlb_sg_name
  }
}

# NLB Security Group - Ingress Rule for 8019 (Service)
resource "aws_security_group_rule" "nlb_sg_ingress_rule_8019" {
  type                     = "ingress"
  from_port                = 8019
  to_port                  = 8019
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web_sg.id
  security_group_id        = aws_security_group.nlb_sg.id
}

# NLB Security Group - Ingress Rule for 8080 (Jenkins)
resource "aws_security_group_rule" "nlb_sg_ingress_rule_8080" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web_sg.id
  security_group_id        = aws_security_group.nlb_sg.id
}

# NLB Security Group - Ingress Rule for 8929 (GitLab)
resource "aws_security_group_rule" "nlb_sg_ingress_rule_8929" {
  type                     = "ingress"
  from_port                = 8929
  to_port                  = 8929
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web_sg.id
  security_group_id        = aws_security_group.nlb_sg.id
}

# NLB Security Group - Egress Rule for 8019 (Service) to WAS Security Group Health Check
resource "aws_security_group_rule" "nlb_sg_egress_rule_8019" {
  type                     = "egress"
  from_port                = 8019
  to_port                  = 8019
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.was_sg.id
  security_group_id        = aws_security_group.nlb_sg.id
}

# NLB Security Group - Egress Rule for 8080 (Jenkins) to WAS Security Group Health Check
resource "aws_security_group_rule" "nlb_sg_egress_rule_8080" {
  type                     = "egress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.was_sg.id
  security_group_id        = aws_security_group.nlb_sg.id
}

# NLB Security Group - Egress Rule for 8929 (GitLab) to WAS Security Group Health Check
resource "aws_security_group_rule" "nlb_sg_egress_rule_8929" {
  type                     = "egress"
  from_port                = 8929
  to_port                  = 8929
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.was_sg.id
  security_group_id        = aws_security_group.nlb_sg.id
}
