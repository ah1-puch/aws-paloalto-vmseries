data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}
data "aws_region" "current" {}

# Debug variables without outputs - all outputs moved to outputs.tf 