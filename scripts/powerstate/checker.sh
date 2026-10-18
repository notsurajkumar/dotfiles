#!/bin/bash

minimum=$(cat /sys/devices/system/cpu/intel_pstate/min_perf_pct)
maximum=$(cat /sys/devices/system/cpu/intel_pstate/max_perf_pct)
fturbo=$(cat /sys/devices/system/cpu/intel_pstate/no_turbo)
fmode=$(cat /sys/firmware/acpi/platform_profile)

echo
echo
echo "CPU min : $minimum"
echo "CPU max : $maximum"
echo "Turbo status : $fturbo"
echo "Mode : $fmode"
echo
echo
