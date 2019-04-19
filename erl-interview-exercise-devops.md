# ERL Take Home Excercise - DevOps

## Goal

Using Terraform, populate a DynamoDB database with specific inputs from a set of files.

## Before you start

The purpose of this challenge is to give us a sense of your skills. When assessing coding challenges, we consider a number of different metrics:

Does the solution meet specifications? 	

Is the code organized and intelligible?	

Does the code suggest an awareness of best practices? (modularity, time/space complexity, etc)		

Is the implementation flexible enough to be re-usable for different inputs?

## Instructions

Using Terraform:

1) Create DynamoDB Table if does not exist, or if has different definition.  The _example_ definition:

```
{
  name = "CodingTask"
  index {
    primary {
      key = [{"columnA": "String"}]
      sort = [{"columnB": "Number"}]
    }
    secondary {
      key = [{"columnA": "String"}]
      sort = [{"columnC": "String"}]
      projection = ["columnD", "columnE"]
    }
  }
}
```

2) Populate the table with fixture values.  The _example_ values:

```
columnA, columnB, columnC, columnD, columnE
tripA, 0, tile1, 12, 12
tripA, 1, tile21, 13, 13
tripB, 0, tile1, -12, -12
tripB, 1, tile21, -13, -13
```

Please keep in mind for this exercise, the example definition and fixture values will be supplied when invoked, and can change from one invocation to another.



