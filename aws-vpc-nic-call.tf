module "cust_nic" {
  source = "git::https://github.com/TechService-Public-Cloud-Products/aws-tf-core-vpc.git?ref=main"
  # source = "../aws-tf-core-vpc"
  
  vpc = {
    network_interface = local.config.network.network_interface
  }
  common = local.config.common
  
  reference = {
    aws_vpc                 = module.cust_vpc.aws_vpc
    aws_subnet              = module.cust_vpc.aws_subnet
    aws_security_group      = module.cust_security_group.aws_security_group
    aws_ec2_transit_gateway = module.cust_vpc.aws_ec2_transit_gateway
  }
}