#!/bin/bash

powermode='/home/rudra/scripts/powerstate/powermode'

printf "Enter min performance percent (1-10) : "
read min
if [[ -z $min ]]; then
  min=8
fi

printf "Enter max performance percent (20-100) : "
read max
if [[ -z $max ]]; then
  max=30
fi


printf "Enter platform power profile (q/b) : " 
read mode

if [[ $mode == "q" ]]; then
  mode='quiet'
elif [[ $mode == "b" ]]; then
  mode='balanced'
else
  mode='quiet'
fi

echo "#!/bin/bash" > $powermode
echo >> $powermode
echo "# Aggressive CPU power saving" >> $powermode
echo "echo $min  > /sys/devices/system/cpu/intel_pstate/min_perf_pct" >> $powermode
echo "echo $max  > /sys/devices/system/cpu/intel_pstate/max_perf_pct" >> $powermode
echo "echo 1  > /sys/devices/system/cpu/intel_pstate/no_turbo" >> powermode
echo >> $powermode
echo "# Lowest platform power profile" >> $powermode
echo "echo $mode | sudo tee /sys/firmware/acpi/platform_profile > /dev/null" >> $powermode
echo
echo

sudo bash $powermode
echo
echo
