module "cust_load_balancer" {
  source = "git::https://github.com/GithubOrg/aws-tf-core-load-balancer.git?ref=main"
  
  datasource    = local.config.network.datasource
  load_balancer = local.config.network.load_balancer
  
  reference = {
    aws_vpc            = module.cust_vpc.aws_vpc
    aws_subnet         = module.cust_vpc.aws_subnet
    aws_security_group = module.cust_security_group.aws_security_group
    aws_instance       = module.cust_ec2.aws_instance
  }

  common        = local.config.common
} 
