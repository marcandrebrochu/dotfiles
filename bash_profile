[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start X automatically when logging in on the first TTY.
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
