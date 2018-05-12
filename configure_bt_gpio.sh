cd /sys/class/gpio
echo 139 > export
echo 146 > export
echo 149 > export
echo 151 > export
echo low > gpio139/direction
echo high > gpio146/direction
echo high > gpio149/direction
echo high > gpio151/direction

