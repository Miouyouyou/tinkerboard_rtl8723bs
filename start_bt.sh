#!/bin/bash
function die_on_error {
	if [ ! $? = 0 ]; then
		echo $1
		exit 1
	fi
}

# Generate the executable if there's a Makefile but
# no rtk_hciattach executable.
if [ ! -f "./rtk_hciattach" ]
then
	if [ -f "./Makefile" ]
	then
		# Generate the executable or exit the script
		# if something wrong happened.
		make
		die_on_error "Make failed :C"
	fi
fi

# Kill any rtk_hciattach actually running.
# Do not complain if we didn't kill anything.
killall -q -SIGTERM rtk_hciattach

# If the GPIO are not yet configured
if [ ! -f "/var/run/rtk_bt/gpio_configured" ];
then
	# We'll create the directory first
	# So that, if the user is not root
	# he'll get a user permission error
	mkdir -p "/var/run/rtk_bt" || die_on_error "Could not create /var/run/rtk_bt"
	./configure_bt_gpio.sh || die_on_error "Could not configure the Bluetooth GPIO"
	echo 1 > /var/run/rtk_bt/gpio_configured || die_on_error "Could not write to /var/run/rtk_bt/configured !"
else
	# If you run the rtk_hciattach once
	# you cannot run it again before
	# resetting the device.
	# Since resetting the device before
	# the first launch generates no issue,
	# we always reset the device.

	# TODO
	# - Check if that doesn't interfere with the WIFI Chip !
	./reset_bt_through_gpio.sh || die_on_error "Could not reset the Bluetooth chip"
	./run_rtk_hciattach.sh ttyS0 || die_on_error "Could not create hci0 through rtk_hciattach"
fi

