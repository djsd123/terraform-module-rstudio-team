resource "aws_iam_role" "ec2_instance_role" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ssm_managed_instance_policy" {
  policy_arn = data.aws_iam_policy.ec2_policy_for_ssm.arn
  role       = aws_iam_role.ec2_instance_role.name
}

resource "aws_iam_role_policy_attachment" "ecs_service_policy" {
  policy_arn = data.aws_iam_policy.ecs_policy_for_ec2.arn
  role       = aws_iam_role.ec2_instance_role.name
}

resource "aws_iam_role_policy_attachment" "ecs_task_service_policy" {
  policy_arn = data.aws_iam_policy.ecs_task_execution_policy.arn
  role       = aws_iam_role.ec2_instance_role.name
}

resource "aws_iam_role_policy_attachment" "s3_read_only_instance_policy" {
  policy_arn = data.aws_iam_policy.s3_read_only_policy.arn
  role       = aws_iam_role.ec2_instance_role.name
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ec2_instance_role.name
}

resource "aws_iam_role" "ecs_task_role" {
  name               = "${var.name}-ecs-task"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_role_service_policy" {
  policy_arn = data.aws_iam_policy.ecs_task_execution_policy.arn
  role       = aws_iam_role.ecs_task_role.name
}

resource "aws_iam_role_policy_attachment" "ecs_ec2_service_role_policy" {
  policy_arn = data.aws_iam_policy.ec2_ecs_service_policy.arn
  role       = aws_iam_role.ecs_task_role.name
}

resource "aws_iam_policy" "logging_policy" {
  name   = "${var.name}-logging"
  policy = data.aws_iam_policy_document.logging_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_logging_policy" {
  policy_arn = aws_iam_policy.logging_policy.arn
  role       = aws_iam_role.ecs_task_role.name
}

resource "aws_iam_policy" "ssm_parameter_policy" {
  name   = "${var.name}-ssm-parameters"
  policy = data.aws_iam_policy_document.ssm_parameter_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_ssm_parameter_policy" {
  policy_arn = aws_iam_policy.ssm_parameter_policy.arn
  role       = aws_iam_role.ecs_task_role.name
}
