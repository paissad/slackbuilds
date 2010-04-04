config() {
    NEW="$1"
    OLD="$(dirname $NEW)/$(basename $NEW .new)"
    # If there's no config file by that name, mv it over:
    if [ ! -r $OLD ]; then
        mv $NEW $OLD
    elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
        # toss the redundant copy
        rm $NEW
    fi
    # Otherwise, we leave the .new copy for the admin to consider...
}

# Keep same perms on etc/httpd/mod_ruby.conf.conf.new:
if [ -e etc/httpd/mod_ruby.conf.conf ]; then
    cp -a etc/httpd/mod_ruby.conf.conf etc/httpd/mod_ruby.conf.conf.new.incoming
    cat etc/httpd/mod_ruby.conf.conf.new > etc/httpd/mod_ruby.conf.conf.new.incoming
    mv etc/httpd/mod_ruby.conf.conf.new.incoming etc/httpd/mod_ruby.conf.conf.new
fi

config etc/httpd/mod_ruby.conf.new

