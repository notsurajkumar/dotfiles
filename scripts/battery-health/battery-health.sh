#!/usr/bin/env bash

BAT=$(upower -e | grep '/battery_')

if [[ -z "$BAT" ]]; then
    echo "No battery found."
    exit 1
fi

get_value() {
    upower -i "$BAT" | awk -v key="$1" '$1 == key {print $2}'
}

ENERGY=$(get_value "energy:")
ENERGY_FULL=$(get_value "energy-full:")
ENERGY_DESIGN=$(get_value "energy-full-design:")
ENERGY_RATE=$(get_value "energy-rate:")
STATE=$(get_value "state:")

HEALTH=$(awk "BEGIN {printf \"%.1f\", ($ENERGY_FULL / $ENERGY_DESIGN) * 100}")

if awk "BEGIN {exit !($ENERGY_RATE > 0)}"; then
    HOURS=$(awk "BEGIN {print $ENERGY / $ENERGY_RATE}")
    TIME=$(awk -v h="$HOURS" 'BEGIN {
        hours = int(h)
        minutes = int((h - hours) * 60)
        printf "%dh %02dm", hours, minutes
    }')
else
    TIME="N/A"
fi

echo
echo "Battery Health : $HEALTH%"
echo "Energy         : $ENERGY Wh"
echo "Energy Rate    : $ENERGY_RATE W"
echo "Time to Empty  : $TIME"
echo "State          : $STATE"
