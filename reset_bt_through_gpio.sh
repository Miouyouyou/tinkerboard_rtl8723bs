#!/bin/bash
echo "Resetting the Bluetooth chip"
cd /sys/class/gpio/gpio149 &&
echo 0 > value &&
echo -e "\tBluetooth chip power down..." &&
sleep 1 &&
echo 1 > value &&
echo -e "\tBluetooth chip power up..." &&
sleep 1
echo -e "\tResetting done"
