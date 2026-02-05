module "cust_transit_gateway" {
  source = "git::https://github.com/TechService-Public-Cloud-Products/aws-tf-core-vpc.git?ref=main"
  # source = "../aws-tf-core-vpc"
  
  vpc = {
    transit_gateway = local.config.network.transit_gateway
  }
  common = local.config.common
  
  reference = {
    aws_vpc    = module.cust_vpc.aws_vpc
    aws_subnet = module.cust_vpc.aws_subnet
  }
} 