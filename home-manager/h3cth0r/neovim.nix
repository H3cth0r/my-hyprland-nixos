{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      autoindent = true;
      wrap = false;
      ignorecase = true;
      smartcase = true;
      clipboard = "unnamedplus";
      linebreak = true;
      cursorline = false;
      backspace = "indent,eol,start";
      splitright = true;
      splitbelow = true;
    };

    extraConfig = ''
      set iskeyword+=-
    '';

    plugins = with pkgs.vimPlugins; [
      nvim-tree-lua
      telescope-fzf-native
      telescope-nvim
      vim-maximizer
      vim-tmux-navigator
    ];

    extraLuaConfig = ''
      -- Nvim-Tree Setup
      require("nvim-tree").setup({
        renderer = {
          icons = {
            glyphs = {
              folder = {
                arrow_closed = "->",
                arrow_open = "L>",
              },
            },
          },
        },
      })
      -- Disable netrw
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- Telescope Setup
      require('telescope').setup({
        defaults = {
          mappings = {
            i = {
              ["<C-k>"] = require('telescope.actions').move_selection_previous,
              ["<C-j>"] = require('telescope.actions').move_selection_next,
              ["<C-q>"] = require('telescope.actions').send_selected_to_qflist + require('telescope.actions').open_qflist,
            },
          },
        },
      })
    '';

    keymaps = [
      # Your keymaps from the original config go here
      { key = "<leader>nh", action = ":nohl<CR>"; }
      { key = "x", mode = "n", action = "\"_x\""; }
      { key = "<leader>+", action = "<C-a>"; }
      { key = "<leader>-", action = "<C-x>"; }
      { key = "<leader>sv", action = "<C-w>v"; }
      { key = "<leader>sh", action = "<C-w>s"; }
      { key = "<leader>se", action = "<C-w>="; }
      { key = "<leader>sx", action = ":close<CR>"; }
      { key = "<leader>to", action = ":tabnew<CR>"; }
      { key = "<leader>tx", action = ":tabclose<CR>"; }
      { key = "<leader>tn", action = ":tabn<CR>"; }
      { key = "<leader>tp", action = ":tabp<CR>"; }
      { key = "<leader>sm", action = ":MaximizerToggle<CR>"; }
      # NvimTree Keymap
      { key = "<leader>ntt", action = ":NvimTreeToggle<CR>"; }
      # Telescope Keymaps
      { key = "<leader>ff", action = "<cmd>Telescope find_files<cr>"; }
      { key = "<leader>fs", action = "<cmd>Telescope live_grep<cr>"; }
      { key = "<leader>fc", action = "<cmd>Telescope grep_string<cr>"; }
      { key = "<leader>fb", action = "<cmd>Telescope buffers<cr>"; }
      { key = "<leader>fh", action = "<cmd>Telescope help_tags<cr>"; }
    ];
  };
}
