module "cust_ec2" {
  source = "git::https://github.com/GithubOrg/aws-tf-core-ec2.git?ref=main"
  # source = "../aws-tf-core-ec2"
  
  datasource  = local.config.compute.datasource
  ec2         = local.config.compute.ec2
  common      = local.config.common
  
  reference = {
    aws_network_interface = module.cust_nic.aws_network_interface
    aws_iam_instance_profile = {
      vmseries_instance_profile = module.cust_iam.aws_iam_instance_profile.vmseries_instance_profile
    }
  }
} 