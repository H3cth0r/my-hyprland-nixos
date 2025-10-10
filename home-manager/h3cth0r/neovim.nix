# CORRECTED: home-manager/h3cth0r/neovim.nix
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

    # --- THIS SECTION IS NOW FULLY CORRECTED ---
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

      -- Keymaps
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }

      map("n", "<leader>nh", ":nohl<CR>", { desc = "No highlight", silent = true })
      map("n", "x", "\"_x\"", { desc = "Delete without yanking", silent = true })
      map("n", "<leader>+", "<C-a>", { desc = "Increment number", silent = true })
      map("n", "<leader>-", "<C-x>", { desc = "Decrement number", silent = true })
      map("n", "<leader>sv", "<C-w>v", { desc = "Split vertically", silent = true })
      map("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally", silent = true })
      map("n", "<leader>se", "<C-w>=", { desc = "Equalize splits", silent = true })
      map("n", "<leader>sx", ":close<CR>", { desc = "Close split", silent = true })
      map("n", "<leader>to", ":tabnew<CR>", { desc = "Open new tab", silent = true })
      map("n", "<leader>tx", ":tabclose<CR>", { desc = "Close current tab", silent = true })
      map("n", "<leader>tn", ":tabn<CR>", { desc = "Next tab", silent = true })
      map("n", "<leader>tp", ":tabp<CR>", { desc = "Previous tab", silent = true })
      map("n", "<leader>sm", ":MaximizerToggle<CR>", { desc = "Toggle maximize split", silent = true })
      
      -- NvimTree Keymap
      map("n", "<leader>ntt", ":NvimTreeToggle<CR>", { desc = "Toggle file tree", silent = true })

      -- Telescope Keymaps
      map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files", silent = true })
      map("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string", silent = true })
      map("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor", silent = true })
      map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "List open buffers", silent = true })
      map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "List help tags", silent = true })
    '';
  };
}
