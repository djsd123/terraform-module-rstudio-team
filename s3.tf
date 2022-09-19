resource "aws_s3_bucket" "rstudio_team" {
  bucket_prefix = "${var.name}-rstudio-team"
  force_destroy = true
}

resource "aws_s3_bucket" "rstudio_access_logs" {
  bucket_prefix = "${var.name}-rstudio-access-logs"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "rstudio_access_logs_policy" {
  bucket = aws_s3_bucket.rstudio_access_logs.bucket
  policy = data.aws_iam_policy_document.s3_access_logs.json
}

#module "s3_workbench_config" {
#  source = "hashicorp/dir/template"
#
#  base_dir = "${path.module}/assets/workbench"
#}
#
#resource "aws_s3_object" "workbench_config" {
#  for_each = module.s3_workbench_config.files
#
#  bucket = aws_s3_bucket.rstudio_team.bucket
#  key    = "workbench/${each.key}"
#  content_type = each.value.content_type
#  source = each.value.source_path
#  etag = each.value.digests.md5
#}
