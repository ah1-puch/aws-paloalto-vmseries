provider "aws" {
  region = local.config.customer.regions.primary
  profile = "AWSAdministratorAccess-606864724315"
}