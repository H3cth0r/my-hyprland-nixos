# CORRECTED: home-manager/h3cth0r/tmux.nix
{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    # This is the correct way to enable the Tmux Plugin Manager
    pluginManager.enable = true;

    # In this list, you put the plugins you want TPM to manage.
    # You DO NOT put 'tpm' itself in this list.
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      # Add any other tmux plugins you want here in the future
    ];

    # Your extra configuration remains the same.
    # Home-Manager will automatically add the TPM startup command for you.
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
