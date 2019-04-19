terraform { backend "local" { path = "state/main.tfstate"} }
variable "profile" {
  type    = "string"
  default = "default"
}

provider "aws" {
  region    = "us-west-1"
  profile   = "${var.profile}"
}

module "dynamodb_table" {
  source = "modules/dynamoDB_table/"
  tableName="${var.Name}"
  primaryKey="${var.primaryKey}"
  primarySort="${var.primarySort}"
  secondaryKey="${var.secondaryKey}"
  secondarySort="${var.secondarySort}"
  secondaryProjection="${var.secondaryProjection}"
}


data "local_file" "fixture" {
  filename="fixture"
}

locals {
  row_list="${split("\n",data.local_file.fixture.content)}"
  slice = "${slice(local.row_list, 1, length(local.row_list))}"
  
}

resource "aws_dynamodb_table_item" "CodingTask_items" {
  count = "${length(local.slice)}"
  table_name = "${module.dynamodb_table.tableName}"
  hash_key   = "${module.dynamodb_table.hashKey}"
  range_key  = "${module.dynamodb_table.rangeKey}"
  item = <<ITEM
{
  "columnA":{"S":"${trimspace(element(split(",", element(local.slice, count.index)), 0))}"},
  "columnB":{"N":"${trimspace(element(split(",", element(local.slice, count.index)), 1))}"},
  "columnC":{"S":"${trimspace(element(split(",", element(local.slice, count.index)), 2))}"},
  "columnD":{"N":"${trimspace(element(split(",", element(local.slice, count.index)), 3))}"},
  "columnE":{"N":"${trimspace(element(split(",", element(local.slice, count.index)), 4))}"}
}
ITEM
}
