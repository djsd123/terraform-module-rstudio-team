resource "aws_cloudwatch_log_group" "rsudio_workbench" {
  name              = "/aws/ecs/${var.name}-rstudio-workbench"
  retention_in_days = 1
}

resource "aws_cloudwatch_log_group" "rsudio_connect" {
  name              = "/aws/ecs/${var.name}-rstudio-connect"
  retention_in_days = 1
}

resource "aws_cloudwatch_log_group" "rsudio_package_manager" {
  name              = "/aws/ecs/${var.name}-rstudio-package-manager"
  retention_in_days = 1
}
