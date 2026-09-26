#!/bin/bash

printf "Enter value : "
read input

n=$(echo $input | cut -d "c" -f1)
r=$(echo $input | cut -d "c" -f2)
((last=$n-$r))
pre_nr=1
pre_dr_1=1
pre_dr_2=1

# numerator
for (( i=1 ; i<=$n ; i++  ))
do
  ((pre_nr=$pre_nr*$i))
done

# denominator part 1
for (( i=1 ; i<=$r ; i++  ))
do
  ((pre_dr_1=$pre_dr_1*$i))
done

# denominator part 2 
for (( i=1 ; i<=$last ; i++  ))
do
  ((pre_dr_2=$pre_dr_2*$i))
done


((denominator=$pre_dr_2*$pre_dr_1))
((answer=$pre_nr/$denominator))

echo
echo "$n! = $pre_nr"
echo "$r! = $pre_dr_1"
echo "$last! = $pre_dr_2"
echo
echo "Value of $input is $answer"

