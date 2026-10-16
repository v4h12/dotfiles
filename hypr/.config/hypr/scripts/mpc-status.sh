#+bin/bash

# artist=$( mpc | head -n 1 | awk -F'-' '{print $1}')
# song=$( mpc | head -n 1 | awk -F'-' '{print $2}')
# time=$( mpc | head -n -1 | awk -F']' '{print $2}')

artist=$(mpc current -f %artist%)
song=$(mpc current -f %title%)
pos=$(mpc status '%songpos%/%length%')
time=$(mpc status '%currenttime%/%totaltime%')

notify-send "$artist" "$song
#$pos - [$time]"
