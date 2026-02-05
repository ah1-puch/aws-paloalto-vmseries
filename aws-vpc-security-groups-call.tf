module "cust_security_group" {
  source = "git::https://github.com/TechService-Public-Cloud-Products/aws-tf-core-security-group.git?ref=main"
  # source = "../aws-tf-core-security-group"
  
  security_group = local.config.network
  common = local.config.common
  
  reference = {
    aws_vpc = module.cust_vpc.aws_vpc
  }
} 