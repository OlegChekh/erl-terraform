from terraform_external_data import terraform_external_data
import json
import re
import csv


@terraform_external_data
def return_data(query):
    output = dict()
    with open('fixture') as csvfile:
        reader = csv.DictReader(csvfile, delimiter=",", skipinitialspace=True)
        b = reader.next()
        for key in b.keys():
            if re.match(r'\-?\d+', b[key]):
                output[key] = "N"
            elif re.match(r'\D+', b[key]):
                output[key] = "S"
    return dict(output)


if __name__ == '__main__':
    return_data()