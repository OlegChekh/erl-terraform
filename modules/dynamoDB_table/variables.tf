variable "tableName" {
  default="CodingTask"
}
variable "primaryKey" {
  default=["columnA","String"]
}
variable "primarySort" {
  default=["columnB","Number"]
}
variable "secondaryKey" {
  default=["columnA","String"]
}
variable "secondarySort" {
  default=["columnC","String"]
}
variable "secondaryProjection" {
  default=["columnD","columnE"]
}
