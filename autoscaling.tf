resource "aws_autoscaling_group" "rstudio_workbench" {
  name_prefix               = "${var.name}-rstudio-workbench-"
  vpc_zone_identifier       = [var.subnet_ids[0]]
  desired_capacity          = var.workbench_desired_capacity
  max_size                  = var.workbench_max_capacity
  min_size                  = var.workbench_min_capacity
  health_check_type         = "EC2"
  health_check_grace_period = 180

  protect_from_scale_in = true
  force_delete          = true

  launch_template {
    id      = aws_launch_template.rstudio_workbench.id
    version = aws_launch_template.rstudio_workbench.latest_version
  }

  instance_refresh {
    strategy = "Rolling"

    preferences {
      min_healthy_percentage = 50
    }

    triggers = ["tag"]
  }

  tag {
    key                 = "launch-template-version"
    propagate_at_launch = true
    value               = aws_launch_template.rstudio_workbench.latest_version
  }

  tag {
    key                 = "ami-id"
    propagate_at_launch = true
    value               = data.aws_ami.amazon_linux_2_ecs.id
  }

  tag {
    key                 = "AmazonECSManaged"
    propagate_at_launch = true
    value               = ""
  }

  depends_on = [aws_launch_template.rstudio_workbench]
}

resource "aws_autoscaling_group" "rstudio_connect" {
  name_prefix         = "${var.name}-rstudio-connect-"
  vpc_zone_identifier = var.subnet_ids
  desired_capacity    = var.connect_desired_capacity
  max_size            = var.connect_max_capacity
  min_size            = var.connect_min_capacity
  health_check_type   = "EC2"

  protect_from_scale_in = true
  force_delete          = true

  launch_template {
    id      = aws_launch_template.rstudio_connect.id
    version = aws_launch_template.rstudio_connect.latest_version
  }

  instance_refresh {
    strategy = "Rolling"

    preferences {
      min_healthy_percentage = 50
    }

    triggers = ["tag"]
  }

  tag {
    key                 = "launch-template-version"
    propagate_at_launch = true
    value               = aws_launch_template.rstudio_connect.latest_version
  }

  tag {
    key                 = "ami-id"
    propagate_at_launch = true
    value               = data.aws_ami.amazon_linux_2_ecs.id
  }

  tag {
    key                 = "AmazonECSManaged"
    propagate_at_launch = true
    value               = ""
  }

  depends_on = [aws_launch_template.rstudio_connect]
}

resource "aws_autoscaling_group" "rstudio_package_manager" {
  name_prefix         = "${var.name}-rstudio-package-manager-"
  vpc_zone_identifier = var.subnet_ids
  desired_capacity    = var.package_manager_desired_capacity
  max_size            = var.package_manager_max_capacity
  min_size            = var.package_manager_min_capacity
  health_check_type   = "EC2"

  protect_from_scale_in = true
  force_delete          = true

  launch_template {
    id      = aws_launch_template.rstudio_package_manager.id
    version = aws_launch_template.rstudio_package_manager.latest_version
  }

  instance_refresh {
    strategy = "Rolling"

    preferences {
      min_healthy_percentage = 50
    }

    triggers = ["tag"]
  }

  tag {
    key                 = "launch-template-version"
    propagate_at_launch = true
    value               = aws_launch_template.rstudio_package_manager.latest_version
  }

  tag {
    key                 = "ami-id"
    propagate_at_launch = true
    value               = data.aws_ami.amazon_linux_2_ecs.id
  }

  tag {
    key                 = "AmazonECSManaged"
    propagate_at_launch = true
    value               = ""
  }

  depends_on = [aws_launch_template.rstudio_package_manager]
}
