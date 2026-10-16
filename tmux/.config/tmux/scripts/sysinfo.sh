#!/bin/sh
# CPU + memory summary for the tmux bottom info bar.
# Output: "CPU nn% | MEM n.nG"

state="${XDG_RUNTIME_DIR:-/tmp}/tmux_sysinfo_cpu"

now=$(awk '/^cpu /{t=0; for(i=2;i<=NF;i++) t+=$i; print t, $5}' /proc/stat)
prev=$(cat "$state" 2>/dev/null)
printf '%s\n' "$now" > "$state"

cpu=0
if [ -n "$prev" ]; then
	nt=${now% *}; ni=${now#* }
	pt=${prev% *}; pi=${prev#* }
	dt=$((nt - pt)); di=$((ni - pi))
	[ "$dt" -gt 0 ] && cpu=$(( (100 * (dt - di)) / dt ))
fi

mem=$(awk '/MemTotal/{t=$2} /MemAvailable/{a=$2} END{printf "%.1fG", (t-a)/1048576}' /proc/meminfo)

printf 'CPU %2d%% | MEM %s' "$cpu" "$mem"
