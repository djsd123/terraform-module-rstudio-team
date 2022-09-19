resource "aws_ecs_capacity_provider" "rstudio_workbench" {
  name = "${var.name}-rstudio-workbench"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.rstudio_workbench.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      maximum_scaling_step_size = 1
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = var.workbench_desired_capacity
    }
  }
}

resource "aws_ecs_capacity_provider" "rstudio_connect" {
  name = "${var.name}-rstudio-connect"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.rstudio_connect.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      maximum_scaling_step_size = 1
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = var.connect_desired_capacity
    }
  }
}

resource "aws_ecs_capacity_provider" "rstudio_package_manager" {
  name = "${var.name}-rstudio-package-manager"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.rstudio_package_manager.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      maximum_scaling_step_size = 1
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = var.package_manager_desired_capacity
    }
  }
}

############## ECS Cluster ################

resource "aws_ecs_cluster" "rstudio_workbench" {
  name = "${var.name}-rstudio-workbench"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "${var.name}-rstudio-workbench"
  }
}

resource "aws_ecs_cluster_capacity_providers" "rstudio_workbench" {
  cluster_name       = aws_ecs_cluster.rstudio_workbench.name
  capacity_providers = [aws_ecs_capacity_provider.rstudio_workbench.name]
}

resource "aws_ecs_cluster" "rstudio_connect" {
  name = "${var.name}-rstudio-connect"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "${var.name}-rstudio-connect"
  }
}

resource "aws_ecs_cluster_capacity_providers" "rstudio_connect" {
  cluster_name       = aws_ecs_cluster.rstudio_connect.name
  capacity_providers = [aws_ecs_capacity_provider.rstudio_connect.name]
}

resource "aws_ecs_cluster" "rstudio_package_manager" {
  name = "${var.name}-rstudio-package-manager"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "${var.name}-rstudio-package-manager"
  }
}

resource "aws_ecs_cluster_capacity_providers" "rstudio_package_manager" {
  cluster_name       = aws_ecs_cluster.rstudio_package_manager.name
  capacity_providers = [aws_ecs_capacity_provider.rstudio_package_manager.name]
}
