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

# Keep same perms on foo.conf.new:
if [ -e etc/foo.conf ]; then
    cp -a etc/foo.conf etc/foo.conf.new.incoming
    cat etc/foo.conf.new > etc/foo.conf.new.incoming
    mv etc/foo.conf.new.incoming etc/foo.conf.new
fi

config etc/foo.conf.new

