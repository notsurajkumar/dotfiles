choices=$(cat ./general.md | gum choose --no-limit)


while IFS= read -r line; do
  echo "$line,"
done <<<  "$choices"
