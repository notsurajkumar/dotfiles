#!/bin/bash


while IFS= read -r line || [[ -n "$line" ]]; do
  first=$(echo $line | awk '{print $1}' )

  if [[ $first == "bind" ]]; then
    echo $line | awk '{for(i=3; i<=6; i++) printf "%s ", $i; print ""}'

  else
    continue
  fi

done < new.conf

