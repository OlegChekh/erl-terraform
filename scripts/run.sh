#!/bin/bash
set -e

pip install pyhocon
pyhocon -i data/definition -o data/definition.json -f json
terraform apply