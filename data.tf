data "aws_caller_identity" "current" {}

data "aws_route53_zone" "zone" {
  name = var.zone_name
}

data "aws_acm_certificate" "cert" {
  domain   = "www.${var.zone_name}"
  statuses = ["ISSUED"]
}

data "aws_ami" "amazon_linux_2_ecs" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }
}

data "aws_iam_policy_document" "ec2_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ecs_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com", "ecs-tasks.amazonaws.com", "ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "s3_access_logs" {
  statement {
    sid    = "AWSLogDeliveryWrite"
    effect = "Allow"

    principals {
      identifiers = ["delivery.logs.amazonaws.com"]
      type        = "Service"
    }
    actions = ["s3:PutObject"]

    resources = ["${aws_s3_bucket.rstudio_access_logs.arn}/*"]

    condition {
      test     = "StringEquals"
      values   = ["bucket-owner-full-control"]
      variable = "s3:x-amz-acl"
    }
  }

  statement {
    sid    = "AWSLogDeliveryAclCheck"
    effect = "Allow"

    principals {
      identifiers = ["delivery.logs.amazonaws.com"]
      type        = "Service"
    }

    actions = ["s3:GetBucketAcl"]

    resources = [aws_s3_bucket.rstudio_access_logs.arn]
  }
}

data "aws_iam_policy_document" "logging_policy" {
  statement {
    sid       = "CloudwatchLogging"
    effect    = "Allow"
    actions   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
    resources = ["arn:aws:logs:*:*:*"]
  }
}

data "aws_iam_policy_document" "ssm_parameter_policy" {
  statement {
    sid       = "SSMGetParameters"
    effect    = "Allow"
    actions   = ["ssm:GetParameter", "ssm:GetParameters", "ssm:GetParametersByPath"]
    resources = ["arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/${var.name}*"]
  }
}

data "aws_iam_policy" "ec2_policy_for_ssm" {
  name = "AmazonSSMManagedInstanceCore"
}

data "aws_iam_policy" "ecs_policy_for_ec2" {
  name = "AmazonEC2ContainerServiceforEC2Role"
}

data "aws_iam_policy" "ecs_task_execution_policy" {
  name = "AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy" "ec2_ecs_service_policy" {
  name = "AmazonEC2ContainerServiceRole"
}

data "aws_iam_policy" "s3_read_only_policy" {
  name = "AmazonS3ReadOnlyAccess"
}

data "cloudinit_config" "workbench_user_data" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "userdata.yaml"
    content_type = "text/cloud-config"
    content = templatefile("${path.module}/assets/userdata.yaml", {
      ClusterName       = aws_ecs_cluster.rstudio_workbench.name
      FileSystemDNSName = "" #module.fsx_rstudio_team.file_system_dns_name
      Region            = var.region
    })
  }
}

data "cloudinit_config" "connect_user_data" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "userdata.yaml"
    content_type = "text/cloud-config"
    content = templatefile("${path.module}/assets/userdata.yaml", {
      ClusterName       = aws_ecs_cluster.rstudio_connect.name
      FileSystemDNSName = "" #module.fsx_rstudio_team.file_system_dns_name
      Region            = var.region
    })
  }
}

data "cloudinit_config" "package_manager_user_data" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "userdata.yaml"
    content_type = "text/cloud-config"
    content = templatefile("${path.module}/assets/userdata.yaml", {
      ClusterName       = aws_ecs_cluster.rstudio_package_manager.name
      FileSystemDNSName = "" #module.fsx_rstudio_team.file_system_dns_name
      Region            = var.region
    })
  }
}
