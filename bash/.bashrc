# ~/.bashrc
# to refresh $ source ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
export PATH="$HOME/.config/emacs/bin:$PATH"

# ----- coloring and shortcuts for programs ----- #
#PS1='[\u@\h \W]\$ ' #user>host>Workingdir>$user#root
# PS1='%n@%m %~\n$ '
PS1='\[\e[97m\]\u@\h \w\n\$ \[\e[0m\]'
alias ls='eza -l --color=always --group-directories-first --hyperlink auto'
# alias cdl='cd {} && ls'
alias la='eza --color=always -T --hyperlink'
alias weather='curl wttr.in/Port+Elizabeth'
alias uplog='cat /var/log/pacman.log | less'
alias icat='kitten icat'
alias space='df -h | grep -A1 Filesystem'
alias hypr='start-hyprland'
alias neofetch="fastfetch"
alias matrix="unimatrix -n -s 96 -l 'o'"
alias print='lp -d Canon_TS5100_series'
alias hy='cd ~/.config/hypr && ls -la'
alias em="emacsclient -t -c -a 'emacs'"
alias semacs="/usr/bin/emacs --daemon --init-directory /home/v4h/.config/emacs"
alias eorg="for f in *.md; do pandoc "$f" -o "${f%.md}.org"; done"
alias bl='blesh-load'
alias za='zathura'
alias usb='cd /run/media/v4h'
alias upd="xdg-open https://archlinux.org/news && sudo pacman -Syu"
alias st="/home/v4h/OCR4Linux/OCR4Linux.sh"
alias godot="cd Coding/packages/godot && ./Godot_v4.6.1-stable_linux.x86_64"
alias ytpl="mpv --no-video "https://www.youtube.com/playlist?list=PLiaJXFKh9MTtuempS8M0MHA7wpiToulgb""
alias ytp="mpv --no-video"
alias venv="source venv/bin/activate"

# tty specific
alias pavutty='pulsemixer' # for audio config
alias btctl='bluetoothctl' # bluetooth config
alias mpvtty='mpv --profile=drm --drm-device=/dev/dri/card1'
alias battery='cat /sys/class/power_supply/BAT0/capacity && cat /sys/class/power_supply/BAT0/status'

# terminal binds
# this line doesnt currently work
# bind -x '"\M-t":trasher -f'

# zellij quickbinds
# alias za="zellij attach"              # attachs most recent session
# alias zls="zellij ls"                 # lists all sessions
# alias zd="zellij delete-all-sessions" # deletes all sessions
# alias zs="zellij -s"                  # creates a session - type name after

# necessary for trasher to work, with autocomplete
eval "$(register-python-argcomplete trasher)"

# check system services with fzf
svc() {
  systemctl list-units --type=service --all |
    fzf --preview 'systemctl status {1}' |
    awk '{print $1}'
}

# ----------- fuzzy find search ---------- #

# alt + c - this is for interactive fzf search for 'cd'

clip() {
  cliphist list -max-items 100 | fzf | cliphist decode | wl-copy
}

# aur and yay detailed search
alias parup="paru -Slq | fzf --multi --preview 'paru -Sii {1}' --preview-window=down:75% --layout=reverse | xargs -ro paru -S"
# file search into editor
alias fzff='nvim "$(find . -type f | fzf --multi --preview "cat {}")"'

# ----- exports for sysman and looks ----- #
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH=/usr/local/bin:$PATH
export EDITOR=/usr/bin/nvim
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# Created by `pipx` on 2026-02-25 08:15:17
export PATH="$PATH:/home/v4h/.local/bin"

# ---------- For looks ---------- #
# makes the prompt disappear to '>' when using zellij
PROMPT_COMMAND='if [ -z "$FIRST_PROMPT" ]; then FIRST_PROMPT=1; else echo; fi'
if [ -z "$ZELLIJ" ]; then
  eval "$(starship init bash)"
else
  PS1='\w > '
fi

# -------------------- #

# // \\ #
# this is for auto-complete (tab) and history (^r)
# you can also go "alt+c" for built-in cd search with fzf
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# Attach ble.sh and to use is '>'(right-arrow)
blesh-load() {
  source /usr/share/blesh/ble.sh
  bleopt highlight_syntax=
  ble-face -s auto_complete fg=gray,bg=none
  # ble-bind -f 'TAB' 'auto_complete/insert'
}

# type 'blesh-load' to enable and 'ble-detach' to disable
# // \\ #

# ------- GENERAL NOTES FOR TERMINAL USE -------

# ~ 'tldr (x)' // for help with terminal commands
# ~ 'ollama serve' to create server > 'ollama list' to see models(x) > 'ollama run (x)' to run model

# -----------------------#

# ------ Script for ollama ------ #
# ------------------------------- #
# . "$HOME/.cargo/env"

# opencode
export PATH=/home/v4h/.opencode/bin:$PATH
