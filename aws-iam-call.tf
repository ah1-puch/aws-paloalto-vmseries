# IAM resources for VM Series
module "cust_iam" {
  source = "git::https://github.com/TechService-Public-Cloud-Products/aws-tf-core-iam.git?ref=main"
  # source = "../aws-tf-core-iam"

  iam = local.config.iam

  common = local.config.common
} 