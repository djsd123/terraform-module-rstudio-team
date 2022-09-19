resource "aws_ecs_service" "rstudio_workbench" {
  name                               = "${var.name}-rstudio-workbench"
  cluster                            = aws_ecs_cluster.rstudio_workbench.id
  task_definition                    = aws_ecs_task_definition.rstudio_workbench.arn
  iam_role                           = aws_iam_role.ecs_task_role.arn
  desired_count                      = 1
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  health_check_grace_period_seconds  = 180
  enable_ecs_managed_tags            = true
  force_new_deployment               = true

  deployment_controller {
    type = "ECS"
  }

  ordered_placement_strategy {
    type  = "binpack"
    field = "memory"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.rstudio_workbench.arn
    container_name   = "${var.name}-rstudio-workbench"
    container_port   = 8787
  }

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.rstudio_workbench.name
    weight            = 1
  }

  tags = {
    Name = "${var.name}-rstudio-workbench"
  }

  depends_on = [aws_lb.rstudio_workbench]
}

resource "aws_ecs_service" "rstudio_connect" {
  name                               = "${var.name}-rstudio-connect"
  cluster                            = aws_ecs_cluster.rstudio_connect.id
  task_definition                    = aws_ecs_task_definition.rstudio_connect.arn
  iam_role                           = aws_iam_role.ecs_task_role.arn
  desired_count                      = 1
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  health_check_grace_period_seconds  = 180
  enable_ecs_managed_tags            = true
  force_new_deployment               = true

  deployment_controller {
    type = "ECS"
  }

  ordered_placement_strategy {
    type  = "binpack"
    field = "memory"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.rstudio_connect.arn
    container_name   = "${var.name}-rstudio-connect"
    container_port   = 3939
  }

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.rstudio_connect.name
    weight            = 1
  }

  tags = {
    Name = "${var.name}-rstudio-connect"
  }

  depends_on = [aws_lb.rstudio_connect]
}

resource "aws_ecs_service" "rstudio_package_manager" {
  name                               = "${var.name}-rstudio-package-manager"
  cluster                            = aws_ecs_cluster.rstudio_package_manager.id
  task_definition                    = aws_ecs_task_definition.rstudio_package_manager.arn
  iam_role                           = aws_iam_role.ecs_task_role.arn
  desired_count                      = 1
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  health_check_grace_period_seconds  = 180
  enable_ecs_managed_tags            = true
  force_new_deployment               = true

  deployment_controller {
    type = "ECS"
  }

  ordered_placement_strategy {
    type  = "binpack"
    field = "memory"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.rstudio_package_manager.arn
    container_name   = "${var.name}-rstudio-package-manager"
    container_port   = 4242
  }

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.rstudio_package_manager.name
    weight            = 1
  }

  tags = {
    Name = "${var.name}-rstudio-package-manager"
  }

  depends_on = [aws_lb.rstudio_package_manager]
}

