variable "profile" {
  type    = "string"
  default = "default"
}

provider "aws" {
  region    = "us-west-1"
  profile   = "${var.profile}"
}

locals {
  fixture=csvdecode(replace(file("data/fixture.csv"),", ",","))
  definition=jsondecode(file("data/definition.json"))
}

data "external" "fixture" {
  program=["python", "scripts/fixture.py"]
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


data "template_file" "fix" {
  count = length(local.fixture)
  template=<<ITEM
{%{ for key,value in local.fixture[count.index] ~}"${key}":{"${data.external.fixture.result[key]}":"${value}"},%{ endfor }}
ITEM
}


resource "aws_dynamodb_table_item" "CodingTask_items" {
  count = length(data.template_file.fix)
  table_name = "${module.dynamodb_table.tableName}"
  hash_key   = "${module.dynamodb_table.hashKey}"
  range_key  = "${module.dynamodb_table.rangeKey}"
  item = replace(data.template_file.fix[count.index].rendered, "},}", "}}")
}
