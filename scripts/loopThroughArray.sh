#!/bin/bash

source ~/dev/temp/temp.sh

INDEX=0

for i in "${arr2[@]}"; do
  torify curl "$i" -o "~/dev/temp/${INDEX}.whatevs"

	echo "========================>"

	let INDEX=${INDEX}+1
done
