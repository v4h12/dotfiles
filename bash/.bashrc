# ~/.bashrc
# to refresh $ source ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
export PATH="$HOME/.config/emacs/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$HOME/.bun/bin:$PATH"
# set to: kitty (kitty/wezterm), sixel (foot/xterm), or symbols (tmux/any terminal)
export FZF_PREVIEW_IMAGE_HANDLER="${FZF_PREVIEW_IMAGE_HANDLER:-symbols}"

# ----- coloring and shortcuts for programs ----- #

PS1='\[\e[97m\]\u@\h \w\n\$ \[\e[0m\]'
eval "$(starship init bash)"
eval "$(zoxide init bash)"

# -------------------- #

# alias because you gotta be a bit lazy (efficient)
alias ls='eza -l --color=always --group-directories-first --hyperlink auto'
alias la='eza --color=always -T --hyperlink'
alias weather='curl wttr.in/Port+Elizabeth'
alias dot='cd ~/dotfiles && ls'
alias uplog='cat /var/log/pacman.log | less'
alias icat='kitten icat'
alias space='df -h | grep -A1 Filesystem'
alias hypr='start-hyprland'
alias neofetch="fastfetch"
alias matrix="unimatrix -n -s 96 -l 'o'"
alias print='lp -d Canon_TS5100_series'
alias em="emacsclient -t -c -a 'emacs'"
alias semacs="/usr/bin/emacs --daemon --init-directory /home/v4h/.config/emacs"
alias eorg="for f in *.md; do pandoc "$f" -o "${f%.md}.org"; done"
alias za='zathura'
alias usb='cd /run/media/v4h'
alias airtui="~/Coding/projects/librepods-tui/librepods-tui/linux-rust/target/release/librepods"
alias upd="xdg-open https://archlinux.org/news && sudo pacman -Syu"
alias st="/home/v4h/OCR4Linux/OCR4Linux.sh"
alias godot="cd Coding/packages/godot && ./Godot_v4.6.1-stable_linux.x86_64"
alias ytpl="mpv --no-video "https://www.youtube.com/playlist?list=PLiaJXFKh9MTtuempS8M0MHA7wpiToulgb""
alias ytp="mpv --no-video"
alias venv="source venv/bin/activate"

# tty specific
alias pavutty='pulsemixer' # for audio config
alias btctl='bluetoothctl' # bluetooth config / or use 'bluetui'
alias mpvtty='mpv --profile=drm --drm-device=/dev/dri/card1'
alias battery='cat /sys/class/power_supply/BAT0/capacity && cat /sys/class/power_supply/BAT0/status'

# necessary for trasher to work, with autocomplete
eval "$(register-python-argcomplete trasher)"

# ----------- fuzzy find search ---------- #

# alt + c - this is for interactive fzf search for 'cd'

# check system services with fzf
svc() {
  systemctl list-units --type=service --all |
    fzf --preview 'systemctl status {1}' |
    awk '{print $1}'
}

# check clipboard
clip() {
  cliphist list -max-items 100 | fzf | cliphist decode | wl-copy
}

# aur and paru detailed search
alias parup="paru -Slq | fzf --multi --preview 'paru -Sii {1}' --preview-window=down:75% --layout=reverse | xargs -ro paru -S"
# file search into editor
alias fzff='nvim "$(find . -type f | fzf --multi --preview "cat {}")"'

# ----- exports for sysman and looks ----- #
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH=/usr/local/bin:$PATH
export EDITOR=/usr/bin/nvim
export LESSOPEN="| grep -P 'alias|$' --color=always %s"
export LESS='-R'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# Created by `pipx` on 2026-02-25 08:15:17
export PATH="$PATH:/home/v4h/.local/bin"

# -------------------- #

# this is for auto-complete (tab) and history (^r)
# you can also go "alt+c" for built-in cd search with fzf
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# -----------------------#

# opencode path (automatically generated)
export PATH=/home/v4h/.opencode/bin:$PATH
