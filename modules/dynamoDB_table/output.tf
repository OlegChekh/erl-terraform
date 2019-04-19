output "tableName" {
  value = "${aws_dynamodb_table.CodingTask.id}"
}
output "hashKey" {
  value = "${var.primaryKey[0]}"
}
output "rangeKey" {
  value = "${var.primarySort[0]}"
}
