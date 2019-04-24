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
  fixture=csvdecode(replace(file("fixture"),", ",","))
  definition=jsondecode(file("definition.json"))
}

data "external" "fixture" {
  program=["python", "fixture.py"]
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
  value = "${data.external.fixture.result[keys(local.fixture[0])[0]]}"
}
output "temp" {
  value = "${keys(local.fixture[0])[0]}"
}
output "temp1" {
  value = "${local.fixture[0][keys(local.fixture[0])[0]]}"
}


resource "aws_dynamodb_table_item" "CodingTask_items" {
  count = length(local.fixture)
  table_name = "${module.dynamodb_table.tableName}"
  hash_key   = "${module.dynamodb_table.hashKey}"
  range_key  = "${module.dynamodb_table.rangeKey}"
  item =<<ITEM
{
  "${keys(local.fixture[count.index])[0]}":{"${data.external.fixture.result[keys(local.fixture[count.index])[0]]}","${local.fixture[count.index][keys(local.fixture[count.index])[0]]}}",
  "${keys(local.fixture[count.index])[1]}":{"${data.external.fixture.result[keys(local.fixture[count.index])[1]]}","${local.fixture[count.index][keys(local.fixture[count.index])[1]]}}",
  "${keys(local.fixture[count.index])[2]}":{"${data.external.fixture.result[keys(local.fixture[count.index])[2]]}","${local.fixture[count.index][keys(local.fixture[count.index])[2]]}}",
  "${keys(local.fixture[count.index])[3]}":{"${data.external.fixture.result[keys(local.fixture[count.index])[3]]}","${local.fixture[count.index][keys(local.fixture[count.index])[3]]}}",
  "${keys(local.fixture[count.index])[4]}":{"${data.external.fixture.result[keys(local.fixture[count.index])[4]]}","${local.fixture[count.index][keys(local.fixture[count.index])[4]]}}"
}
ITEM
}
