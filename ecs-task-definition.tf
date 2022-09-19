resource "aws_ecs_task_definition" "rstudio_workbench" {
  family        = "${var.name}-rstudio-workbench"
  task_role_arn = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name       = "${var.name}-rstudio-workbench"
      image      = var.workbench_image
      cpu        = var.workbench_cpu
      memory     = var.workbench_memory
      essential  = true
      privileged = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/aws/ecs/${var.name}-rstudio-workbench"
          awslogs-region        = var.region
          awslogs-stream-prefix = "ecs"
        }
      }
      portMappings = [
        {
          containerPort = 8787
          hostPort      = 8787
        },
        {
          containerPort = 5559
          hostPort      = 5559
        }
      ]
      environment = [
        {
          name  = "RSW_LICENSE"
          value = aws_ssm_parameter.rstudio_workbench_license.value
          # TODO use secrets manager/parameter store
        }
      ]
      mountPoints = [
        {
          containerPath = "/tmp/rstudio/"
          sourceVolume  = "data"
        }
      ]
    }
  ])

  volume {
    name      = "data"
    host_path = "/mnt/fsx"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [eu-west-1a]"
  }

  depends_on = [aws_s3_bucket.rstudio_team]
}

resource "aws_ecs_task_definition" "rstudio_connect" {
  family        = "${var.name}-rstudio-connect"
  task_role_arn = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = "${var.name}-rstudio-connect"
      image     = var.connect_image
      cpu       = var.connect_cpu
      memory    = var.connect_memory
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/aws/ecs/${var.name}-rstudio-connect"
          awslogs-region        = var.region
          awslogs-stream-prefix = "ecs"
        }
      }
      portMappings = [
        {
          containerPort = 3939
          hostPort      = 3939
        }
      ]
      environment = [
        {
          name  = "RSC_LICENSE"
          value = aws_ssm_parameter.rstudio_connect_license.value
          # TODO use secrets manager/parameter store
        }
      ]
      mountPoints = [
        {
          containerPath = "/tmp/rstudio/"
          sourceVolume  = "data"
        }
      ]
    }
  ])

  volume {
    name      = "data"
    host_path = "/mnt/fsx"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [eu-west-1a, eu-west-1b, eu-west-1c]"
  }

  depends_on = [aws_s3_bucket.rstudio_team]
}

resource "aws_ecs_task_definition" "rstudio_package_manager" {
  family        = "${var.name}-rstudio-package-manager"
  task_role_arn = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = "${var.name}-rstudio-package-manager"
      image     = var.package_manager_image
      cpu       = var.package_manager_cpu
      memory    = var.package_manager_memory
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/aws/ecs/${var.name}-rstudio-package-manager"
          awslogs-region        = var.region
          awslogs-stream-prefix = "ecs"
        }
      }
      portMappings = [
        {
          containerPort = 4242
          hostPort      = 4242
        }
      ]
      environment = [
        {
          name  = "RSPM_LICENSE"
          value = aws_ssm_parameter.rstudio_package_manager_license.value
          # TODO use secrets manager/parameter store
        }
      ]
      mountPoints = [
        {
          containerPath = "/tmp/rstudio/"
          sourceVolume  = "data"
        }
      ]
    }
  ])

  volume {
    name      = "data"
    host_path = "/mnt/fsx"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [eu-west-1a, eu-west-1b, eu-west-1c]"
  }

  depends_on = [aws_s3_bucket.rstudio_team]
}
