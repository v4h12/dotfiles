# ~/.bashrc
# to refresh $ source ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ----- coloring and shortcuts for programs ----- #
#PS1='[\u@\h \W]\$ ' #user>host>Workingdir>$user#root
# PS1='%n@%m %~\n$ '
PS1='\[\e[97m\]\u@\h \w\n\$ \[\e[0m\]'
alias ls='eza -l --color=always --group-directories-first --hyperlink'
alias la='eza --color=always -T --hyperlink'
alias grep='grep --color=auto'
alias neofetch="fastfetch"
alias matrix="unimatrix -n -s 96 -l 'o'"
alias print='lp -d Canon_TS5100_series'
alias bl='blesh-load'
alias upd="xdg-open https://archlinux.org/news && sudo pacman -Syu"
alias st="/home/v4h/OCR4Linux/OCR4Linux.sh"

#git aliases
alias gis="git status"
alias gia="git add"
alias gic="git commit -m"
alias gip="git push"

# zellij quickbinds
alias za="zellij attach"              # attachs most recent session
alias zls="zellij ls"                 # lists all sessions
alias zd="zellij delete-all-sessions" # deletes all sessions
alias zs="zellij -s"                  # creates a session - type name after

# check system services with fzf
svc() {
  systemctl list-units --type=service --all |
    fzf --preview 'systemctl status {1}' |
    awk '{print $1}'
}

# ----------- fuzzy find search ---------- #

# alt + c - this is for interactive fzf search for 'cd'

# aur and yay detailed search
alias parup="paru -Slq | fzf --multi --preview 'paru -Sii {1}' --preview-window=down:75% --layout=reverse | xargs -ro paru -S"
# file search into micro editor
alias fzff='nvim "$(find . -type f | fzf --preview "cat {}")"'

# ----- exports for sysman and looks ----- #
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH=/usr/local/bin:$PATH
export EDITOR=/usr/bin/nvim

# ---------- For looks ---------- #
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
# source /usr/share/nvm/init-nvm.sh
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
