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

# Keep same perms on rc.policyd.new:
if [ -e etc/rc.d/rc.policyd ]; then
  cp -a etc/rc.d/rc.policyd etc/rc.d/rc.policyd.new.incoming
  cat etc/rc.d/rc.policyd.new > etc/rc.d/rc.policyd.new.incoming
  mv etc/rc.d/rc.policyd.new.incoming etc/rc.d/rc.policyd.new
fi

# Keep same perms on cluebringer.conf.new:
if [ -e etc/cluebringer.conf ]; then
  cp -a etc/cluebringer.conf etc/cluebringer.conf.new.incoming
  cat etc/cluebringer.conf.new > etc/cluebringer.conf.new.incoming
  mv etc/cluebringer.conf.new.incoming etc/cluebringer.conf.new
fi

DOCROOT=var/www/htdocs
# a little more security is good ! (we remove 1st slash if it exists)
DOCROOT=$( echo $DOCROOT | sed 's|^/||')

# Keep same perms on config.php.new:
if [ -e $DOCROOT/policyd/includes/config.php ]; then
  cp -a $DOCROOT/policyd/includes/config.php $DOCROOT/policyd/includes/config.php.incoming
  cat $DOCROOT/policyd/includes/config.php.new > $DOCROOT/policyd/includes/config.php.incoming
  mv $DOCROOT/policyd/includes/config.php.incoming $DOCROOT/policyd/includes/config.php.new
fi

config etc/rc.d/rc.policyd.new
config etc/cluebringer.conf.new
config $DOCROOT/policyd/includes/config.php.new

