About
-----

This a fork of https://github.com/lwfinger/rtl8723bs_bt targeted
towards RK3288 Tinkerboard users.  
There are a few additonal scripts that enable the right GPIO and reset
the Bluetooth chip to make `rtk_hciattach` work correctly on these
specific boards.

[If you don't have a RK3288 board or Tinkerboard systems, do not use
this fork. Use the official one.](https://github.com/lwfinger/rtl8723bs_bt)

This is currently tested with my [patched 4.17-rcX kernel](https://github.com/Miouyouyou/RockMyy).

Usage
-----

Run `./start_bt.sh`. It will run `make` automatically for you.

You should see something like this on the first run :

```
root@tinkerboard:/path/to/rtl8723bs_bt# ./start_bt.sh 
cc -c hciattach_rtk.c
cc -o rtk_hciattach hciattach.c hciattach_rtk.o  
Using device /dev/ttyS0 for Bluetooth
```

On the second run, you'll see :
```
root@tinkerboard:/path/to/rtl8723bs_bt# ./start_bt.sh 
Using device /dev/ttyS0 for Bluetooth
```

The original readme.txt
-----------------------

```
This directory contains the programs and firmware to operate the Bluetooth
section of the RTL8723BS hardware used on a number of tablets.

The main program is called rtk_hciattach. To build this program, issue the
following command:

make

To install the firmware (only needed once):

sudo make install

Some users have found that an alternate firmware works for them. To try this
firmware, do this command:

sudo cp rtlbt_fw_new /lib/firmware/rtl_bt/rtlbt_fw

To start Bluetooth (needed for each boot), use the command

sudo ~/rtl8723bs_bt/start_bt.sh

Note: The script assumes that the Bluetooth device is attached to /dev/ttyS4.
That may not be correct for your system. To discover the correct serial port,
run 'dmesg | grep tty'. You should see two lines that say "ttyXX at MMIO 0xYYYYYYYY.
Edit start_bt.sh to set the definition of TTY to use the value of XX for the first
of these two lines.

As this command will need to be done everytime the system is rebooted, you
might consider placing this command in the system startup commands. The path
of the command will have to be adjusted.

WARNING: This driver needs the H5 protocol, which is built into kernels 3.12
and later. If you need to use an earlier kernel, raise an issue on this repo.

Larry Finger
```

