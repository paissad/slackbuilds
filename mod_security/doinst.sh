config() {
    NEW="$1"
    OLD="$(dirname $NEW)/$(basename $NEW .new)"
    # If there's no config file by that name, mv it over:
    if [ ! -r $OLD ]; then
        mv $NEW $OLD
    elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW |  md5sum)" ]; then
        # toss the redundant copy
        rm $NEW
    fi
    # Otherwise, we leave the .new copy for the admin to consider...
}

CONF_LIST_NEW="etc/mlogc.conf.new \
etc/rules-updater-example.conf.new \
etc/rules-updater.conf.new \
etc/httpd/extra/mod_security.conf.new"

### config stuffs ####
for conf_new in $CONF_LIST_NEW; do
    config $conf_new;
done
for conf_new in etc/httpd/modsecurity.d/*.new; do
    config $conf_new
done
for conf_new in etc/httpd/modsecurity.d/base_rules/*.new; do
    config $conf_new
done
for conf_new in etc/httpd/modsecurity.d/optional_rules/*.new; do
    config $conf_new
done
