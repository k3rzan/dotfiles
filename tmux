# set shell
set -g default-shell /usr/bin/zsh

# avoid overwriting Neovim colors
#set-option -ga terminal-overrides ",screen-256color:Tc"
set -g default-terminal "tmux-256color"
set -ga terminal-overrides ",*256col*:Tc"
set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
set -g base-index 1
set -g history-limit 9999999
set-environment -g COLORTERM "truecolor"


# resizing
bind -r h resize-pane -L 5
bind -r j resize-pane -D 5
bind -r k resize-pane -U 5
bind -r l resize-pane -R 5

# spliting
bind C-h split-window -v #split horizontally
bind C-v split-window -h #split vertically
