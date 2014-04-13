# Let graphical programs know where to show up.
# This used to be based on $GDM_XSERVER_LOCATION,
# but that doesn't seem to be available on Koala.
if [ -z "$DISPLAY" ] && [ "$USER" = "eswald" ]
then
  xline="\/\(bin\|X11\)\/X :"
  display=$(ps -AH -ouser,cmd | \
    sed "/$xline/{x;d};/^root /d;/^$USER /{x;/$xline/p;d};x;d" | \
    head -n 1 | cut -d: -f2 | cut -d' ' -f1)
  if [ -n "$display" ]; then
    export DISPLAY=:$display
  fi
fi
