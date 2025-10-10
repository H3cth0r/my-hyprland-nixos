{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      tpm
      vim-tmux-navigator
    ];
    extraConfig = ''
      set -g default-terminal "screen-256color"
      set -g prefix C-a
      unbind C-b
      bind-key C-a send-prefix

      unbind r
      bind r source-file ~/.config/tmux/tmux.conf

      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r l resize-pane -R 5
      bind -r h resize-pane -L 5

      bind -r m resize-pane -Z
      set -g mouse on
      set -g renumber-windows on
    '';
  };
}
