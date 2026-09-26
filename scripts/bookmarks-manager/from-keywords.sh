#!/bin/bash 

brave_cmd='brave --profile-directory=Default '
brave_inc_cmd='brave --profile-directory=Default --incognito'
links='/home/rudra/scripts/bookmarks-manager/links.md'
output_keywords='/home/rudra/scripts/bookmarks-manager/tmp_keywords'
output_sites='/home/rudra/scripts/bookmarks-manager/tmp_sites'
final_keywords='/home/rudra/scripts/bookmarks-manager/tmp_final_keywords'
target_links='/home/rudra/scripts/bookmarks-manager/target_links'
  
while IFS= read -r line; do
  site=$(echo $line | awk -F "|" '{print $1}')
  keywords=$(echo $line | awk -F "|" '{print $2}' | cut -b1 --complement)
  echo "$site" >> $output_sites
  echo "$keywords" >> $output_keywords 
done < "$links" 


while IFS= read -r line; do
  max=$(echo "$line" | awk -F ';' '{total += NF} END {print total}')

  for (( i=1 ; i<=$max ; i++)); do
    echo $line | awk -v i=$i -F ";" '{print $i}' >> $final_keywords
  done 

done < "$output_keywords"


# rofi menu

chosen_keyword=$(cat $final_keywords | sort | uniq | rofi -dmenu -i -p "Search links   "  -kb-accept-custom "" -kb-custom-1 "Control+Return")
exit_code=$?

if [[ -n $chosen_keyword ]]; then

  resulting_link=$(cat $links | grep -w "$chosen_keyword" | cut -d "|" -f1)
  echo "$resulting_link" > $target_links

  no_of_results=$(cat $target_links | wc -l)

  if [[ $no_of_results == 1 ]]; then
    if [ "$exit_code" -eq 0 ]; then
      $brave_cmd $resulting_link
    elif [ "$exit_code" -eq 10 ]; then
      $brave_inc_cmd $resulting_link
    fi
  else
    resulting_link=$(cat $target_links | rofi -dmenu -i -p "$chosen_keyword   "  -kb-accept-custom "" -kb-custom-1 "Control+Return")
exit_code=$?


    if [[ -n $resulting_link ]]; then
      if [ "$exit_code" -eq 0 ]; then
        $brave_cmd $resulting_link
      elif [ "$exit_code" -eq 10 ]; then
        $brave_inc_cmd $resulting_link
      fi 
    else 
      :
    fi

  fi

else 
  :
fi


# cleaning up
rm $output_keywords 
rm $output_sites
rm $final_keywords
rm $target_links
