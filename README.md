# erl-terraform
ERL Take Home Excercise

**Task was done using Terraform version 0.12-beta 2**
Binary of this version can be downloaded [Here](https://releases.hashicorp.com/terraform/0.12.0-beta2/)

## Goal

Using Terraform, populate a DynamoDB database with specific inputs from a set of files.

### How to run
To run this task input data [table definition](#table-definition) and [table fixture](#table-fixture) need to be stored in data folder.

Task can be run by run.sh stored in scripts folder.

**run.sh should be executed from task root folder.**
```
./scripts/run.sh
```

This script will install pyhocon tool, convert input data and run terraform

### Table definition
Incoming parameters for Table Definition should be saved into data/definition file
Table definition should be converted to json. To do this can be used Pyhocon tool
```
pip install pyhocon
pyhocon -i data/definition -o data/definition.json -f json
```

### Table Fixture
Table fixture should be stored in a file "data/fixture.csv"

## Links
[Original Task Markdown](erl-interview-exercise-devops.md)