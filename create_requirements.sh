#!/bin/bash
requirements_path=${1}

for n in "${@:2}";
do
  echo ${n} >> $requirements_path/requirements.txt
done