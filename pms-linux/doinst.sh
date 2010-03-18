config() {
    NEW="$1"
    OLD="$(dirname $NEW)/$(basename $NEW .new)"
    # If there's no config file by that name, mv it over:
    if [ ! -r $OLD ]; then
        mv $NEW $OLD
    elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW |
        md5sum)" ]; then
        # toss the redundant copy
        rm $NEW
    fi
    # Otherwise, we leave the .new copy for the admin to consider...
}

config etc/PMS.conf.new
config etc/WEB.conf.new
config etc/logrotate.d/pms-linux.new
config etc/rc.d/rc.pms-linux.new

if [ ! -e usr/share/pms-linux/PMS.conf ]; then
    ( cd usr/share/pms-linux/ ; ln -sf ../../../etc/PMS.conf . )
fi
if [ ! -e usr/share/pms-linux/WEB.conf ]; then
    ( cd usr/share/pms-linux/ ; ln -sf ../../../etc/WEB.conf . )
fi

