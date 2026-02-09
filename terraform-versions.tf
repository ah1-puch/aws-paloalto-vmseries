terraform {

  required_version = "< 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "< 6.0.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "> 2.0.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "> 0.12.0"
    }
    utils = {
      source  = "cloudposse/utils"
      version = "> 1.0.0"
    }
  }

  backend "s3" {
    bucket       = "tfstate-networking-15160685"
    key          = "networking.tfstate"
    region       = "eu-west-1"
    use_lockfile = true
  }
}
