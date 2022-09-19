#module "fsx_rstudio_team" {
#  source = "./fsx-lustre"
#
#  name = "${var.name}-rstudio-team-config"
#  region = var.region
#  vpc_id = var.vpc_id
#  subnet_id = var.subnet_ids[0]
#
#  security_group_ids = [
#    aws_security_group.rstudio_package_manager.id,
#    aws_security_group.rstudio_workbench.id,
#    aws_security_group.rstudio_connect.id
#  ]
#
##  s3_import_path = "s3://${aws_s3_bucket.rstudio_team.bucket}"
#}
