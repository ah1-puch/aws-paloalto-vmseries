module "cust_vpc" {
  source = "git::https://github.com/GithubOrg/aws-tf-core-vpc.git?ref=main"
  # source = "../aws-tf-core-vpc"
  
  # Only pass VPC and subnet configuration, exclude network_interface and transit_gateway
  vpc = {
    vpc         = local.config.network.vpc
    subnet      = local.config.network.subnet
    route_table = local.config.network.route_table
    route       = local.config.network.route
  }
  common = local.config.common
  
  reference = {
    aws_ec2_transit_gateway = module.cust_transit_gateway.aws_ec2_transit_gateway
  }
} 