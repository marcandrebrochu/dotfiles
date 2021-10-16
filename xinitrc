# Test for an existing dbus daemon and launch one if none exists.
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval $(dbus-launch --sh-syntax --exit-with-session)
fi

# Workaround so that I can show notification from my user services!!
echo "$DBUS_SESSION_BUS_ADDRESS" > ~/.cache/dbus-session-address

# Load Xresources file, if it exists.
if [ -f ~/.Xresources ]; then
    xrdb ~/.Xresources
fi

# Some keyboard configuration.
setxkbmap -model thinkpad
setxkbmap -layout us # use the change-kbd-layout script to change layouts
setxkbmap -option caps:swapescape # swap escape with caps lock

# Set a background image.
feh --no-fehbg --bg-fill '/home/mab/.background-art/Vermeer/TGWTPE.jpg'

# For my keybindings.
sxhkd &

# Replace the current shell with the dwm process.
exec dwm
