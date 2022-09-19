resource "aws_ssm_parameter" "rstudio_workbench_license" {
  name        = "/${var.name}/rsw-license"
  description = "The RStudio Workbench container license key"
  type        = "SecureString"
  value       = var.workbench_license_rsw
}

resource "aws_ssm_parameter" "rstudio_connect_license" {
  name        = "/${var.name}/rsc-license"
  description = "The RStudio Connect container license key"
  type        = "SecureString"
  value       = var.connect_license_rsc
}

resource "aws_ssm_parameter" "rstudio_package_manager_license" {
  name        = "/${var.name}/rspm-license"
  description = "The RStudio Package Manager container license key"
  type        = "SecureString"
  value       = var.package_manager_license_rspm
}
