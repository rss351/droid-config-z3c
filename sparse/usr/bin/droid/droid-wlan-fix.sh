#!/bin/sh

# This ensures existence of /dev/block/platform/msm_sdcc.1/by-name/
# then starts the tad_static daemon, and finally executes
# addrsetup to make the wifi module have a MAC address.

if [ ! -d /dev/block/platform/msm_sdcc.1/by-name/ ]; then
        mkdir -p /dev/block/platform/msm_sdcc.1/
        ln -s /dev/block/msm_sdcc.1/mmc_host/by-name /dev/block/platform/msm_sdcc.1/by-name
fi

# Make sure that the /etc/firmware directory is linked
if [ ! -d /etc/firmware/ ]; then
    ln -s /system/etc/firmware /etc/
fi

# Make sure that the codecs are linked
if [ ! -f /etc/media_codecs.xml ]; then
    ln -s /system/etc/media_*.xml /etc/
fi

# # Start tad static, which requires the above folder to exist.
# /system/bin/tad_static /dev/block/mmcblk0 1,16

# For some reason tad_static takes about a second to start and do it's thing.
sleep 1

# Now addrsetup can give our wlan device a mac address!
## /system/bin/addrsetup /sys/devices/platform/bcmdhd_wlan/macaddr

# # CM12 uses taimport instead
# /system/bin/taimport 

