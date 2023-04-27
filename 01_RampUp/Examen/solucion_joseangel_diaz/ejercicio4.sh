#!/bin/bash

read -p "¿Que número necesitas?:" tabladel

echo $tabladel

for i in {0..10}; do
  resultado=$((tabladel * i))
  echo "$tabladel * $i = $resultado"
done