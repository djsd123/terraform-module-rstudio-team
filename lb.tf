locals {
  load_balancer_port     = 443
  load_balancer_protocol = "TLS"
}

resource "aws_lb" "rstudio_workbench" {
  name_prefix                      = "${var.name}-wb"
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = true
  internal                         = false
  subnets                          = var.loadbalancer_subnet_ids

  access_logs {
    bucket  = aws_s3_bucket.rstudio_access_logs.id
    prefix  = "${var.name}-rstudio-workbench"
    enabled = true
  }

  tags = {
    Name = "${var.name}-rstudio-workbench"
  }
}

resource "aws_lb_target_group" "rstudio_workbench" {
  name_prefix          = "${var.name}-wb"
  port                 = 8787
  protocol             = "TCP"
  vpc_id               = var.vpc_id
  deregistration_delay = "30"
  target_type          = "instance"

  health_check {
    protocol            = "HTTP"
    interval            = "30"
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

  tags = {
    Name = "${var.name}-rstudio-workbench"
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_lb.rstudio_workbench]
}

resource "aws_lb_listener" "rstudio_workbench" {
  load_balancer_arn = aws_lb.rstudio_workbench.arn
  port              = local.load_balancer_port
  protocol          = local.load_balancer_protocol
  alpn_policy       = "HTTP2Preferred"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rstudio_workbench.arn
  }
}

######## Connect ########

resource "aws_lb" "rstudio_connect" {
  name_prefix                      = "${var.name}-co"
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = true
  internal                         = false
  subnets                          = var.loadbalancer_subnet_ids

  access_logs {
    bucket  = aws_s3_bucket.rstudio_access_logs.id
    prefix  = "${var.name}-rstudio-connect"
    enabled = true
  }

  tags = {
    Name = "${var.name}-rstudio-connect"
  }
}

resource "aws_lb_target_group" "rstudio_connect" {
  name_prefix          = "${var.name}-co"
  port                 = local.load_balancer_port
  protocol             = local.load_balancer_protocol
  vpc_id               = var.vpc_id
  deregistration_delay = "30"

  health_check {
    protocol            = "TCP"
    interval            = "30"
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

  tags = {
    Name = "${var.name}-rstudio-connect"
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_lb.rstudio_connect]
}

resource "aws_lb_listener" "rstudio_connect" {
  load_balancer_arn = aws_lb.rstudio_connect.arn
  port              = local.load_balancer_port
  protocol          = local.load_balancer_protocol
  alpn_policy       = "HTTP2Preferred"
  certificate_arn   = data.aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rstudio_connect.arn
  }
}

######## Package Manager ########

resource "aws_lb" "rstudio_package_manager" {
  name_prefix                      = "${var.name}-pm"
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = true
  internal                         = false
  subnets                          = var.loadbalancer_subnet_ids

  access_logs {
    bucket  = aws_s3_bucket.rstudio_access_logs.id
    prefix  = "${var.name}-rstudio-package-manager"
    enabled = true
  }

  tags = {
    Name = "${var.name}-rstudio-package-manager"
  }
}

resource "aws_lb_target_group" "rstudio_package_manager" {
  name_prefix          = "${var.name}-pm"
  port                 = local.load_balancer_port
  protocol             = local.load_balancer_protocol
  vpc_id               = var.vpc_id
  deregistration_delay = "30"

  health_check {
    protocol            = "TCP"
    interval            = "30"
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

  tags = {
    Name = "${var.name}-rstudio-package-manager"
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_lb.rstudio_package_manager]
}

resource "aws_lb_listener" "rstudio_package_manager" {
  load_balancer_arn = aws_lb.rstudio_package_manager.arn
  port              = local.load_balancer_port
  protocol          = local.load_balancer_protocol
  alpn_policy       = "HTTP2Preferred"
  certificate_arn   = data.aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rstudio_package_manager.arn
  }
}
