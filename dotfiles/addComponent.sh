#!/bin/sh

mkdir $1
cd $1
echo "import $1 from './$1'" >> index.js
echo "export default $1" >> index.js
touch $1.js