# convenience_scripts
Some small pieces of code that I use on my daily basis

--- 

## [power_indicator.sh](https://github.com/amateusz/convenience_scripts/blob/master/power_indicator.sh)
returns current power draw in Watts. Auto detects multiple batteries. Indicates charging with "↑", otherwise discharging.  
`-` Watts designates idle state: battery is essentially internally disconnected.
<img src="https://user-images.githubusercontent.com/9356928/64735861-b0314c00-d4e9-11e9-86f2-732897c5aca1.png" align=center width="60%"></img>  
Use `--plain` switch to make the output simple (for non-kArgos users)

---

## shutdown_button.sh
Raspberry π ACPI necessity. Adds 
this one crucial button. _No more SSHing a RPi only to shut it down even though you have physical access to it._ It can trigger different actions based on the duration of the press.  
It uses BCM numbering (wiringPi -g).  
My default actions are shutdown and reboot.  
 My preffered GPIO is some on CSI connector (I²C line?).  
  My preffered button is iPhone 3GS home button glued to the USB casing.
\<to be done\>

---

## many others
