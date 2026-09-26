#!/bin/bash

echo "Enter display name"
read display_name

echo "Enter channel link"
read channel_link

# general categories
general=$(cat ./general.md | gum choose --no-limit)
final_general=$(
while IFS= read -r line; do
  echo "$line,"
done <<<  "$general"
)


# specific categories
specific=$(cat ./specific.md | gum choose --no-limit)
final_specific=$(
while IFS= read -r line; do
  echo "$line,"
done <<<  "$specific"
)


echo 
echo
echo $display_name
echo $channel_link
echo "$final_general"
echo "$final_specific"
