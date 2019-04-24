resource "aws_dynamodb_table" "CodingTask" {
    name="${var.tableName}"
    hash_key="${var.primaryKey[0]}"
    range_key="${var.primarySort[0]}"
    read_capacity  = 10
    write_capacity = 10
    attribute{
        name="${var.primaryKey[0]}"
        type="${substr(var.primaryKey[1],0,1)}"
    }
    attribute{
        name="${var.primarySort[0]}"
        type="${substr(var.primarySort[1],0,1)}"
    }
    attribute{
        name="${var.secondaryKey[0]}"
        type="${substr(var.secondaryKey[1],0,1)}"
    }
    attribute{
        name="${var.secondarySort[0]}"
        type="${substr(var.secondarySort[1],0,1)}"
    }
    global_secondary_index {
        name="secondary"
        hash_key="${var.secondaryKey[0]}"
        range_key="${var.secondarySort[0]}"
        read_capacity  = 10
        write_capacity = 10
        projection_type="INCLUDE"
        non_key_attributes="${var.secondaryProjection}"
    }
}
