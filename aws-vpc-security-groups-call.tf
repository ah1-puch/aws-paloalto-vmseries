module "cust_security_group" {
  source = "git::https://github.com/GithubOrg/aws-tf-core-security-group.git?ref=main"
  
  security_group = local.config.network
  
  reference = {
    aws_vpc = module.cust_vpc.aws_vpc
  }

  common = local.config.common
} 