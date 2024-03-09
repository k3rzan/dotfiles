# set shell
set -g default-shell /usr/bin/zsh

# avoid overwriting Neovim colors
set-option -ga terminal-overrides ",xterm-256color:Tc"


# resizing
bind -r h resize-pane -L 5
bind -r j resize-pane -D 5
bind -r k resize-pane -U 5
bind -r l resize-pane -R 5

# spliting
bind C-h split-window -v #split horizontally
bind C-v split-window -h #split vertically
