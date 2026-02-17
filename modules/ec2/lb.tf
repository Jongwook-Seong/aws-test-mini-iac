# ALB
resource "aws_lb" "alb" {
  name               = var.elb.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [var.vpc.pub_subnet_01_id, var.vpc.pub_subnet_02_id]

  enable_deletion_protection = false

  tags = {
    Name = var.elb.alb_name
  }
}

# ALB Listener for HTTP
resource "aws_lb_listener" "alb_listener_http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_80.arn
  }
}

# ALB Listener for HTTPS
resource "aws_lb_listener" "alb_listener_https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTPS"

  certificate_arn = data.aws_acm_certificate.issued.arn
  ssl_policy      = "ELBSecurityPolicy-2016-08"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_443.arn
  }
}

# ALB Listener for 8080 (Jenkins)
resource "aws_lb_listener" "alb_listener_8080" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 8080
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "8080"
      protocol    = "HTTP"
      status_code = "HTTP_301"
      path        = "/login"
    }
  }
}

resource "aws_lb_listener_rule" "alb_listener_rule_8080" {
  listener_arn = aws_lb_listener.alb_listener_8080.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_8080.arn
  }

  condition {
    path_pattern {
      values = ["/login"]
    }
  }
}

# ALB Listener for 8929 (GitLab)
resource "aws_lb_listener" "alb_listener_8929" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 8929
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "8929"
      protocol    = "HTTP"
      status_code = "HTTP_301"
      path        = "/auth/sign_in"
    }
  }
}

resource "aws_lb_listener_rule" "alb_listener_rule_8929" {
  listener_arn = aws_lb_listener.alb_listener_8929.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_8929.arn
  }

  condition {
    path_pattern {
      values = ["/auth/sign_in"]
    }
  }
}

# NLB
resource "aws_lb" "nlb" {
  name               = var.elb.nlb_name
  internal           = true
  load_balancer_type = "network"
  security_groups    = [aws_security_group.nlb_sg.id]
  subnets            = [var.vpc.pri_subnet_01_id, var.vpc.pri_subnet_02_id]

  enable_deletion_protection = false

  tags = {
    Name = var.elb.nlb_name
  }
}

# NLB Listener for 8019 (Service)
resource "aws_lb_listener" "nlb_listener_8019" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = 8019
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_tg_8019.arn
  }
}

# NLB Listener for 8019 (Service)
resource "aws_lb_listener" "nlb_listener_8080" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = 8080
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_tg_8080.arn
  }
}

# NLB Listener for 8929 (GitLab)
resource "aws_lb_listener" "nlb_listener_8929" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = 8929
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_tg_8929.arn
  }
}
