#!/bin/bash


powermode='/home/rudra/scripts/powerstate/powermode'
template='/home/rudra/scripts/powerstate/template'


cat $template > $powermode && sudo bash $powermode 

minimum=$(cat /sys/devices/system/cpu/intel_pstate/min_perf_pct)
maximum=$(cat /sys/devices/system/cpu/intel_pstate/max_perf_pct)
fturbo=$(cat /sys/devices/system/cpu/intel_pstate/no_turbo)
fmode=$(cat /sys/firmware/acpi/platform_profile)

echo
echo
echo "CPU min : $minimum"
echo "CPU max : $maximum"
echo
echo

if [[ $maximum == "80" ]];then
  systemctl suspend
else
  echo "run the sleep script again!"
fi
