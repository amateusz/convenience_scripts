# intended to work with kArgos (bitbar). (output formatting)

#!/bin/bash
EXTRA_CHARS=''
IDLE=true

for BATTERY in BAT0 BAT1; do
	STATUS=$(cat /sys/class/power_supply/$BATTERY/status)
	if [ -e /sys/class/power_supply/$BATTERY/power_now ]; then
		UWATTS=$(cat /sys/class/power_supply/$BATTERY/power_now)
	else
		UWATTS=$(( `cat /sys/class/power_supply/$BATTERY/voltage_now` + `cat /sys/class/power_supply/$BATTERY/current_now` ))
	fi
	case $STATUS in
		"Discharging")
			IDLE=false
			break;;
		"Charging")
			IDLE=false
			EXTRA_CHARS='↑'
			if [ "$BATTERY" = 'BAT0' ]; then EXTRA_CHARS="$EXTRA_CHARS wewn."; fi
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
echo "$WATTS W $EXTRA_CHARS | size=11 font=ComicSansMS color=#eeee22"
echo "---"
# echo "Kernel: $(uname -r) | iconName=system-settings iconName=applications-development"
echo "<your action here> | bash='sh -c /home/mateusz/programowanie/skrypciory/sutek_ps2_lewa.sh' onclick=bash terminal=false iconName=input-touchpad"
