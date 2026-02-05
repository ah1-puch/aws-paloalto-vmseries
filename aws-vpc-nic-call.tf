module "cust_nic" {
  source = "git::https://github.com/GithubOrg/aws-tf-core-vpc.git?ref=main"
  
  vpc = {
    network_interface = local.config.network.network_interface
  }
  
  reference = {
    aws_vpc                 = module.cust_vpc.aws_vpc
    aws_subnet              = module.cust_vpc.aws_subnet
    aws_security_group      = module.cust_security_group.aws_security_group
    aws_ec2_transit_gateway = module.cust_vpc.aws_ec2_transit_gateway
  }

  common = local.config.common
}
