# ALB Target Group for 80 (HTTP)
resource "aws_lb_target_group" "alb_tg_80" {
  vpc_id      = var.vpc_id
  name        = "${var.elb.alb_tg_name}-80"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"

  health_check {
    port                = 80
    protocol            = "HTTP"
    path                = "/*"
    interval            = 5
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name        = "${var.elb.alb_tg_name}-80"
    Description = "ALB Target Group for HTTP"
  }
}

resource "aws_lb_target_group_attachment" "alb_tg_80_attachment" {
  target_group_arn = aws_lb_target_group.alb_tg_80.arn
  target_id        = aws_instance.web01_server.id
  port             = 80
}

# ALB Target Group for 443 (HTTPS)
resource "aws_lb_target_group" "alb_tg_443" {
  vpc_id      = var.vpc_id
  name        = "${var.elb.alb_tg_name}-443"
  target_type = "instance"
  port        = 443
  protocol    = "HTTPS"

  health_check {
    port                = 443
    protocol            = "HTTPS"
    path                = "/*"
    interval            = 5
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name        = "${var.elb.alb_tg_name}-443"
    Description = "ALB Target Group for HTTPS"
  }
}

resource "aws_lb_target_group_attachment" "alb_tg_443_attachment" {
  target_group_arn = aws_lb_target_group.alb_tg_443.arn
  target_id        = aws_instance.web01_server.id
  port             = 443
}

# ALB Target Group for 8080 (Jenkins)
resource "aws_lb_target_group" "alb_tg_8080" {
  vpc_id      = var.vpc_id
  name        = "${var.elb.alb_tg_name}-8080"
  target_type = "instance"
  port        = 8080
  protocol    = "HTTP"

  health_check {
    port                = 8080
    protocol            = "HTTP"
    path                = "/login"
    interval            = 5
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name        = "${var.elb.alb_tg_name}-8080"
    Description = "ALB Target Group for 8080 Jenkins"
  }
}

resource "aws_lb_target_group_attachment" "alb_tg_8080_attachment" {
  target_group_arn = aws_lb_target_group.alb_tg_8080.arn
  target_id        = aws_instance.web01_server.id
  port             = 8080
}

# ALB Target Group for 8929 (GitLab)
resource "aws_lb_target_group" "alb_tg_8929" {
  vpc_id      = var.vpc_id
  name        = "${var.elb.alb_tg_name}-8029"
  target_type = "instance"
  port        = 8929
  protocol    = "HTTP"

  health_check {
    port                = 8929
    protocol            = "HTTP"
    path                = "/auth/sign_in"
    interval            = 5
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name        = "${var.elb.alb_tg_name}-8929"
    Description = "ALB Target Group for 8929 GitLab"
  }
}

resource "aws_lb_target_group_attachment" "alb_tg_8929_attachment" {
  target_group_arn = aws_lb_target_group.alb_tg_8929.arn
  target_id        = aws_instance.web01_server.id
  port             = 8929
}

# NLB Target Group for 8019 (Service)
resource "aws_lb_target_group" "nlb_tg_8019" {
  vpc_id      = var.vpc_id
  name        = "${var.elb.nlb_tg_name}-8019"
  target_type = "instance"
  port        = 8019
  protocol    = "TCP"

  health_check {
    port                = 8019
    protocol            = "HTTP"
    path                = "/*"
    interval            = 5
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name        = "${var.elb.nlb_tg_name}-8019"
    Description = "NLB Target Group for 8019 Service"
  }
}

resource "aws_lb_target_group_attachment" "nlb_tg_8019_attachment" {
  target_group_arn = aws_lb_target_group.nlb_tg_8019.arn
  target_id        = aws_instance.was01_server.id
  port             = 8019
}

# NLB Target Group for 8080 (Jenkins)
resource "aws_lb_target_group" "nlb_tg_8080" {
  vpc_id      = var.vpc_id
  name        = "${var.elb.nlb_tg_name}-8080"
  target_type = "instance"
  port        = 8080
  protocol    = "TCP"

  health_check {
    port                = 8080
    protocol            = "HTTP"
    path                = "/login"
    interval            = 5
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name        = "${var.elb.nlb_tg_name}-8080"
    Description = "NLB Target Group for 8080 Jenkins"
  }
}

resource "aws_lb_target_group_attachment" "nlb_tg_8080_attachment" {
  target_group_arn = aws_lb_target_group.nlb_tg_8080.arn
  target_id        = aws_instance.was01_server.id
  port             = 8080
}

# NLB Target Group for 8929 (GitLab)
resource "aws_lb_target_group" "nlb_tg_8929" {
  vpc_id      = var.vpc_id
  name        = "${var.elb.nlb_tg_name}-8929"
  target_type = "instance"
  port        = 8929
  protocol    = "TCP"

  health_check {
    port                = 8929
    protocol            = "HTTP"
    path                = "/auth/sign_in"
    interval            = 5
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name        = "${var.elb.nlb_tg_name}-8929"
    Description = "NLB Target Group for 8929 GitLab"
  }
}

resource "aws_lb_target_group_attachment" "nlb_tg_8929_attachment" {
  target_group_arn = aws_lb_target_group.nlb_tg_8929.arn
  target_id        = aws_instance.was01_server.id
  port             = 8929
}
