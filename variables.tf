variable "name" {
  type        = string
  description = "Common name for all resources"
}

variable "region" {
  type        = string
  description = "The region to deploy the resources"
}

variable "zone_name" {
  type        = string
  description = "The name of the route53 zone to use for DNS"

  default = "sub.mcallison.co.uk"
}

variable "vpc_id" {
  type        = string
  description = "The Id of the VPC to deploy compute resources to"
}

variable "subnet_ids" {
  type        = list(string)
  description = "The subnet ids to associate with the compute resources"
}

variable "loadbalancer_subnet_ids" {
  type        = list(string)
  description = "The subnet ids to associate with the load balancers i.e. public or private. Public recommended"
}

variable "security_group_id" {
  type        = string
  description = "Additional Security group Id to add resulting instances to"

  default = ""
}

variable "ingress_cidr_blocks" {
  type        = list(string)
  description = "List of CIDRs to allow ingress"

  default = ["0.0.0.0/0"]
}


variable "egress_cidr_blocks" {
  type        = list(string)
  description = "List of CIDRs to allow egress"

  default = ["0.0.0.0/0"]
}

variable "workbench_instance_type" {
  type        = string
  description = "EC2 Instance type for RStudio Workbench. Default is t3.large"

  default = "t3.large"
}

variable "connect_instance_type" {
  type        = string
  description = "EC2 Instance type for RStudio Connect. Default is t3.large"

  default = "t3.large"
}

variable "package_manager_instance_type" {
  type        = string
  description = "EC2 Instance type for RStudio Package Manager. Default is t3.large"

  default = "t3.large"
}

variable "ec2_key_pair" {
  type        = string
  description = "The EC2 key pair to use for ssh connections"
}

variable "workbench_desired_capacity" {
  type        = number
  description = "The number of RStudio Workbench instances desired"

  default = 1
}

variable "connect_desired_capacity" {
  type        = number
  description = "The number of RStudio Connect instances desired"

  default = 1
}

variable "package_manager_desired_capacity" {
  type        = number
  description = "The number of RStudio Package Manager instances desired"

  default = 1
}

variable "workbench_min_capacity" {
  type        = number
  description = "The minimum number of RStudio Workbench instances desired"

  default = 1
}

variable "connect_min_capacity" {
  type        = number
  description = "The minimum number of RStudio Connect instances desired"

  default = 1
}

variable "package_manager_min_capacity" {
  type        = number
  description = "The minimum number of RStudio Package Manager instances desired"

  default = 1
}

variable "workbench_max_capacity" {
  type        = number
  description = "The maximum number of RStudio Workbench instances desired"

  default = 1
}

variable "connect_max_capacity" {
  type        = number
  description = "The maximum number of RStudio Connect instances desired"

  default = 1
}

variable "package_manager_max_capacity" {
  type        = number
  description = "The maximum number of RStudio Package Manager instances desired"

  default = 1
}

variable "workbench_image" {
  type        = string
  description = "The container image to use for RStudio Workbench"

  default = "rstudio/rstudio-workbench"
}

variable "connect_image" {
  type        = string
  description = "The container image to use for RStudio Connect"

  default = "rstudio/rstudio-connect"
}

variable "package_manager_image" {
  type        = string
  description = "The container image to use for RStudio Package Manager"

  default = "rstudio/rstudio-package-manager"
}

variable "workbench_cpu" {
  type        = number
  description = "The cpu units reserved for the RStudio Workbench container"

  default = 99
}

variable "connect_cpu" {
  type        = number
  description = "The cpu units reserved for the RStudio Connect container"

  default = 99
}

variable "package_manager_cpu" {
  type        = number
  description = "The cpu units/shares reserved for the RStudio Package Manager container"

  default = 99
}

variable "workbench_memory" {
  type        = number
  description = "The amount (in MiB) of memory to assign to the RStudio Workbench container"

  default = 2048
}

variable "connect_memory" {
  type        = number
  description = "The amount (in MiB) of memory to assign to the RStudio Connect container"

  default = 1024
}

variable "package_manager_memory" {
  type        = number
  description = "The amount (in MiB) of memory to assign to the RStudio Package Manager container"

  default = 1024
}

variable "workbench_license_rsw" {
  type        = string
  description = "The RStudio Workbench container license key"
}

variable "connect_license_rsc" {
  type        = string
  description = "The RStudio Connect container license key"
}

variable "package_manager_license_rspm" {
  type        = string
  description = "The RStudio Package Manager container license key"
}
