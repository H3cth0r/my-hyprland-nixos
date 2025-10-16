# FINAL, SELF-CONTAINED, AND CORRECTED: home-manager/h3cth0r/neovim.nix
{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      nvim-web-devicons
      nvim-tree-lua
      telescope-fzf-native-nvim
      telescope-nvim
      # vim-maximizer has been REMOVED to solve the error permanently.
      vim-tmux-navigator
    ];

    extraConfig = ''
      set number
      set relativenumber
      set shiftwidth=2
      set tabstop=2
      set expandtab
      set autoindent
      set nowrap
      set ignorecase
      set smartcase
      set clipboard=unnamedplus
      set linebreak
      set nocursorline
      set backspace=indent,eol,start
      set splitright
      set splitbelow
      set iskeyword+=-

      augroup transparent_nvim
      	autocmd!
	autocmd VimEnter * hi Normal guibg=NONE ctermbg=NONE
      augroup END
    '';

    extraLuaConfig = ''
      -- Nvim-Tree Setup
      require("nvim-tree").setup({
        renderer = {
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
            glyphs = {
              default = "󰈚",
              symlink = "",
              folder = {
                arrow_closed = "▸",
                arrow_open = "▾",
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
                symlink_open = "",
              },
              git = {
                unstaged = "",
                staged = "S",
                unmerged = "",
                renamed = "➜",
                untracked = "U",
                deleted = "",
                ignored = "◌",
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

      -- Self-contained window maximizer function
      local function toggle_maximizer()
        local current_win = vim.api.nvim_get_current_win()
        if vim.g.maximizer_win == current_win then
          vim.cmd('wincmd =')
          vim.g.maximizer_win = nil
        else
          vim.g.maximizer_win = current_win
          vim.cmd('wincmd |')
          vim.cmd('wincmd _')
        end
      end
      vim.g.toggle_maximizer = toggle_maximizer

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
      
      -- Keymap now calls our own Lua function
      map("n", "<leader>sm", "<cmd>lua vim.g.toggle_maximizer()<CR>", { desc = "Toggle maximize split", silent = true })
      
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
