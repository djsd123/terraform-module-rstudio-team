resource "aws_launch_template" "rstudio_workbench" {
  name_prefix                          = "${var.name}-rstudio-workbench-"
  ebs_optimized                        = true
  description                          = "Launch template for ${var.name}-rstudio-workbench"
  image_id                             = data.aws_ami.amazon_linux_2_ecs.id
  instance_type                        = var.workbench_instance_type
  key_name                             = var.ec2_key_pair
  vpc_security_group_ids               = [aws_security_group.rstudio_workbench.id]
  update_default_version               = true
  disable_api_termination              = false
  instance_initiated_shutdown_behavior = "terminate"

  monitoring {
    enabled = true
  }

  iam_instance_profile {
    arn = aws_iam_instance_profile.ec2_instance_profile.arn
  }

  user_data = data.cloudinit_config.workbench_user_data.rendered

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.name}-rstudio-workbench"
    }
  }

  tags = {
    Name = "${var.name}-rstudio-workbench-template"
  }
}

resource "aws_launch_template" "rstudio_connect" {
  name_prefix                          = "${var.name}-rstudio-connect-"
  ebs_optimized                        = true
  description                          = "Launch template for ${var.name}-rstudio-connect"
  image_id                             = data.aws_ami.amazon_linux_2_ecs.id
  instance_type                        = var.connect_instance_type
  key_name                             = var.ec2_key_pair
  vpc_security_group_ids               = [aws_security_group.rstudio_connect.id, var.security_group_id]
  update_default_version               = true
  disable_api_termination              = false
  instance_initiated_shutdown_behavior = "terminate"

  monitoring {
    enabled = true
  }

  iam_instance_profile {
    arn = aws_iam_instance_profile.ec2_instance_profile.arn
  }

  user_data = data.cloudinit_config.connect_user_data.rendered

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.name}-rstudio-connect"
    }
  }

  tags = {
    Name = "${var.name}-rstudio-connect-template"
  }
}

resource "aws_launch_template" "rstudio_package_manager" {
  name_prefix                          = "${var.name}-rstudio-package-manager-"
  ebs_optimized                        = true
  description                          = "Launch template for ${var.name}-rstudio-package-manager"
  image_id                             = data.aws_ami.amazon_linux_2_ecs.id
  instance_type                        = var.package_manager_instance_type
  key_name                             = var.ec2_key_pair
  vpc_security_group_ids               = [aws_security_group.rstudio_package_manager.id]
  update_default_version               = true
  disable_api_termination              = false
  instance_initiated_shutdown_behavior = "terminate"

  monitoring {
    enabled = true
  }

  iam_instance_profile {
    arn = aws_iam_instance_profile.ec2_instance_profile.arn
  }

  user_data = data.cloudinit_config.package_manager_user_data.rendered

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.name}-rstudio-package-manager"
    }
  }

  tags = {
    Name = "${var.name}-rstudio-package-manager-template"
  }
}
