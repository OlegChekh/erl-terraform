# terraform { backend "local" { path = "state/main.tfstate"} }
variable "profile" {
  type    = "string"
  default = "default"
}

provider "aws" {
  region    = "us-west-1"
  profile   = "${var.profile}"
}

locals {
  fixture=csvdecode(replace(var.fixture,", ",","))
  definition=jsondecode(file("definition.json"))
}

module "dynamodb_table" {
  source = "./modules/dynamoDB_table/"
  tableName="${local.definition.name}"
  primaryKey=[keys(local.definition.index.primary.key[0])[0],lookup(local.definition.index.primary.key[0],keys(local.definition.index.primary.key[0])[0])]
  primarySort=[keys(local.definition.index.primary.sort[0])[0],lookup(local.definition.index.primary.sort[0],keys(local.definition.index.primary.sort[0])[0])]
  secondaryKey=[keys(local.definition.index.secondary.key[0])[0],lookup(local.definition.index.secondary.key[0],keys(local.definition.index.secondary.key[0])[0])]
  secondarySort=[keys(local.definition.index.secondary.sort[0])[0],lookup(local.definition.index.secondary.sort[0],keys(local.definition.index.secondary.sort[0])[0])]
  secondaryProjection="${local.definition.index.secondary.projection}"
}

output "fixture" {
  value = "${local.fixture}"
}

# resource "aws_dynamodb_table_item" "CodingTask_items" {
#   count = length(local.fixture)
#   table_name = "${module.dynamodb_table.tableName}"
#   hash_key   = "${module.dynamodb_table.hashKey}"
#   range_key  = "${module.dynamodb_table.rangeKey}"
#   item = <<ITEM
# {
#   "columnA":"${local.fixture[count.index].columnA}",
#   "columnB":"${local.fixture[count.index].columnB}",
#   "columnC":"${local.fixture[count.index].columnC}",
#   "columnD":"${local.fixture[count.index].columnD}",
#   "columnE":"${local.fixture[count.index].columnE}"
# }
# ITEM
# }
