export ROS_IP=192.168.1.2
export ROS_MASTER_URI=http://192.168.1.127:11311
export NAO_IP=192.168.1.2
export OPENROBOTS=/opt/openrobots
export PATH=$PATH:$OPENROBOTS/sbin:$OPENROBOTS/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$OPENROBOTS/lib
export PYTHONPATH=$PYTHONPATH:$OPENROBOTS/lib/python2.7/site-packages
export MANPATH=$MANPATH:$OPENROBOTS/man
# if ROS is installed, source setup.bash
[ -f "$OPENROBOTS/etc/ros/setup.bash" ] && source $OPENROBOTS/etc/ros/setup.bash
# use this alias to install sysdeps to /opt/local
# convenient to re-distribute the whole system
alias emergelocal='emerge -G --root=/opt/local'
# make sure aliases are preserved
# through sudo (cf http://serverfault.com/a/178956)
# note the trailing space
alias sudo='sudo '
export OPENROBOTS=/opt/openrobots
export PATH=$PATH:$OPENROBOTS/sbin:$OPENROBOTS/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$OPENROBOTS/lib
export PYTHONPATH=$PYTHONPATH:$OPENROBOTS/lib/python2.7/site-packages
export MANPATH=$MANPATH:$OPENROBOTS/man
# if ROS is installed, source setup.bash
[ -f "$OPENROBOTS/etc/ros/setup.bash" ] && source $OPENROBOTS/etc/ros/setup.bash
# use this alias to install sysdeps to /opt/local
# convenient to re-distribute the whole system
alias emergelocal='emerge -G --root=/opt/local'
# make sure aliases are preserved
# through sudo (cf http://serverfault.com/a/178956)
# note the trailing space
alias sudo='sudo '
