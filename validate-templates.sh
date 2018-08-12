#!/bin/bash
set -e

# Validate aws templates (assumes sceptre dir convention)
TEMPLATES=templates/*
for template in $TEMPLATES
do
  dir="${template%/*}"
  file="${template##*/}"
  extension="${file##*.}"
  filename="${file%.*}"
  echo -e "\nValidating ${template}"
  aws cloudformation validate-template --template-body file://${template}
done
