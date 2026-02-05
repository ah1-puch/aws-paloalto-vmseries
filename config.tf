#
# Read configuration files
#

locals {
  config = jsondecode(data.utils_deep_merge_json.config.output)
}

data "utils_deep_merge_json" "config" {
  input = [
    for file in fileset("${path.cwd}/${path.module}/configuration/", "aws-*.json") :
    file("${path.module}/configuration/${file}")
  ]
}
