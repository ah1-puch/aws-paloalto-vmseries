module "cust_load_balancer" {
  source = "git::https://github.com/TechService-Public-Cloud-Products/aws-tf-core-load-balancer.git?ref=main"
  # source = "../aws-tf-core-load-balancer"
  
  datasource    = local.config.network.datasource
  load_balancer = local.config.network.load_balancer
  common        = local.config.common
  
  reference = {
    aws_vpc            = module.cust_vpc.aws_vpc
    aws_subnet         = module.cust_vpc.aws_subnet
    aws_security_group = module.cust_security_group.aws_security_group
    aws_instance       = module.cust_ec2.aws_instance
  }
} 