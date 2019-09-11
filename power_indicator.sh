#!/bin/bash
EXTRA_CHARS=''
IDLE=true
PLAIN=false

# args. switch output between kArgos and plain (for general use, e.g. xfce which lacks argos)
[ ! -z "$1" ] && [ "$1" = "--plain" ] && PLAIN=true

# count them batteries
BATTERY_COUNT=$(ls /sys/class/power_supply | grep BAT[0-99] | wc -w)

for BATTERY in `seq -f "BAT%g" 0 $(( $BATTERY_COUNT - 1 ))` ; do
	STATUS=$(cat /sys/class/power_supply/$BATTERY/status)
	if [ -e /sys/class/power_supply/$BATTERY/power_now ]; then
		UWATTS=$(cat /sys/class/power_supply/$BATTERY/power_now)
	else
		UWATTS=$(( `cat /sys/class/power_supply/$BATTERY/voltage_now` * `cat /sys/class/power_supply/$BATTERY/current_now` / 1000000 ))
	fi
	case $STATUS in
		"Discharging")
			IDLE=false
			break;;
		"Charging")
			IDLE=false
			EXTRA_CHARS='↑'
			if [ "$BATTERY" = 'BAT0' && $BATTERY_COUNT -gt 1 ]; then EXTRA_CHARS="$EXTRA_CHARS wewn."; fi # "wewn." stands for "internal" in Polish
			break;;
		"Unknown")
			continue;;
	esac
done

if $IDLE; then
	WATTS='—'
else
	WATTS=$(bc -l <<< "scale=1; $UWATTS/1000000.0")
	WATTS=$(tr . , <<< $WATTS)
fi

# printing output
if $PLAIN; then
	echo "$WATTS W $EXTRA_CHARS"
else 
	echo "$WATTS W $EXTRA_CHARS | size=11 font=ComicSansMS color=#eeee22"
	echo "---"
	# echo "Kernel: $(uname -r) | iconName=system-settings iconName=applications-development"
	echo "klawisz sutka | bash='sh -c /home/mateusz/programowanie/skrypciory/sutek_ps2_lewa.sh' onclick=bash terminal=false iconName=input-touchpad"
fi
