# IAM resources for VM Series
module "cust_iam" {
  source = "git::https://github.com/GithubOrg/aws-tf-core-iam.git?ref=main"
  # source = "../aws-tf-core-iam"

  iam = local.config.iam

  common = local.config.common
} 