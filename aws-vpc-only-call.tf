module "cust_vpc" {
  source = "git::https://github.com/GithubOrg/aws-tf-core-vpc.git?ref=main"

  vpc = {
    vpc         = local.config.network.vpc
    subnet      = local.config.network.subnet
    route_table = local.config.network.route_table
    route       = local.config.network.route
  }
  
  reference = {
    aws_ec2_transit_gateway = module.cust_transit_gateway.aws_ec2_transit_gateway
  }

  common = local.config.common
} 
