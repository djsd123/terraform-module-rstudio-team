resource "aws_security_group" "rstudio_workbench" {
  name        = "${var.name}-rstudio-workbench"
  description = "RStudio Workbench access"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.name}-rstudio-workbench"
  }
}

resource "aws_security_group_rule" "workbench_ingress_port" {
  from_port         = 8787
  protocol          = "tcp"
  security_group_id = aws_security_group.rstudio_workbench.id
  to_port           = 8787
  type              = "ingress"
  cidr_blocks       = var.ingress_cidr_blocks
  description       = "Web access to RStudio Workbench"
}

resource "aws_security_group_rule" "workbench_ingress_https" {
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.rstudio_workbench.id
  to_port           = 80
  type              = "ingress"
  cidr_blocks       = var.ingress_cidr_blocks
  description       = "Web access to RStudio Workbench"
}

resource "aws_security_group_rule" "workbench_ingress_connect" {
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rstudio_workbench.id
  to_port                  = 443
  type                     = "ingress"
  source_security_group_id = aws_security_group.rstudio_connect.id
  description              = "RStudio Connect inbound access to RStudio Workbench"
}

resource "aws_security_group_rule" "workbench_ingress_package_manager" {
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rstudio_workbench.id
  to_port                  = 443
  type                     = "ingress"
  source_security_group_id = aws_security_group.rstudio_package_manager.id
  description              = "RStudio Package Manager inbound access to RStudio Workbench"
}

resource "aws_security_group_rule" "workbench_egress" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.rstudio_workbench.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = var.egress_cidr_blocks
  description       = "Rstudio Workbench outbound"
}

resource "aws_security_group" "rstudio_connect" {
  name        = "${var.name}-rstudio-connect"
  description = "RStudio Connect access"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.name}-rstudio-connect"
  }
}

resource "aws_security_group_rule" "connect_ingress_https" {
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.rstudio_connect.id
  to_port           = 443
  type              = "ingress"
  cidr_blocks       = var.ingress_cidr_blocks
  description       = "Web access to RStudio Connect"
}

resource "aws_security_group_rule" "connect_ingress_workbench" {
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rstudio_connect.id
  to_port                  = 443
  type                     = "ingress"
  source_security_group_id = aws_security_group.rstudio_workbench.id
  description              = "RStudio workbench inbound access to RStudio Connect"
}

resource "aws_security_group_rule" "connect_ingress_package_manager" {
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rstudio_connect.id
  to_port                  = 443
  type                     = "ingress"
  source_security_group_id = aws_security_group.rstudio_package_manager.id
  description              = "RStudio Package Manager inbound access to RStudio Connect"
}

resource "aws_security_group_rule" "connect_egress" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.rstudio_connect.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = var.egress_cidr_blocks
  description       = "Rstudio Workbench outbound"
}

resource "aws_security_group" "rstudio_package_manager" {
  name        = "${var.name}-rstudio-package-manager"
  description = "RStudio Package Manager access"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.name}-rstudio-connect"
  }
}

resource "aws_security_group_rule" "package_manager_ingress_https" {
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.rstudio_package_manager.id
  to_port           = 443
  type              = "ingress"
  cidr_blocks       = var.ingress_cidr_blocks
  description       = "Web access to RStudio Package Manager"
}

resource "aws_security_group_rule" "package_manager_ingress_workbench" {
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rstudio_package_manager.id
  to_port                  = 443
  type                     = "ingress"
  source_security_group_id = aws_security_group.rstudio_workbench.id
  description              = "RStudio Package Manager inbound access to RStudio Workbench"
}

resource "aws_security_group_rule" "package_manager_ingress_connect" {
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rstudio_package_manager.id
  to_port                  = 443
  type                     = "ingress"
  source_security_group_id = aws_security_group.rstudio_connect.id
  description              = "RStudio Package Manager inbound access to RStudio Connect"
}

resource "aws_security_group_rule" "package_manager_egress" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.rstudio_package_manager.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = var.egress_cidr_blocks
  description       = "Rstudio Package Manager outbound"
}
