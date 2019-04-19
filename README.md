# erl-terraform
ERL Take Home Excercise

**Task was done using latest stable Terraform version (0.11.13)**

## Goal

Using Terraform, populate a DynamoDB database with specific inputs from a set of files.

### Table definition
Incoming parameters for Table Definition should be next:
```
Name="CodingTask"
primaryKey=["columnA","String"]
primarySort=["columnB","Number"]
secondaryKey=["columnA","String"]
secondarySort=["columnC","String"]
secondaryProjection=["columnD","columnE"]
```

### Table Fixture
Table fixture should be stored in a file "fixture" within root folder.
Please note: Structure of fixture has strict data type of columns
```
"columnA":"String"
"columnB":"Number"
"columnC":"String"
"columnD":"Number"
"columnE":"Number"
```

## Links
[Original Task Markdown](erl-interview-exercise-devops.md)