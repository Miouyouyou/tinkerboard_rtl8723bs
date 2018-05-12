if [ ! -f "/var/run/rtk_bt/gpio_configured" ];
then
	# We'll create the directory first
	# So that, if the user is not root
	# he'll get a user permission error
	mkdir -p "/var/run/rtk_bt"
	./configure_bt_gpio.sh
	echo 1 > /var/run/rtk_bt/configured
else
	# If you run the rtk_hciattach once
	# you cannot run it again before
	# resetting the device.
	# Since resetting the device before
	# the first launch generates no issue,
	# we always reset the device.
	./reset_bt_through_gpio.sh
	./run_rtk_hciattach.sh ttyS0
fi

