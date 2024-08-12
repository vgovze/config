-- Provided by TJ De Vries (Kickstart neovim).
--  NOTE: For nvim basics type :Tutor.

-- Set <space> as the leader key. See `:help mapleader`.
--  NOTE: Must happen before plugins are loaded.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`. See `:help option-list`.
vim.opt.encoding = "utf-8"

-- Make line numbers default.
vim.opt.number = true

-- Disable relative numbers.
vim.opt.relativenumber = false

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line.
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim. See `:help 'clipboard'`.
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Enable autoindent
vim.opt.autoindent = true

-- Enable smartindent
vim.opt.smartindent = true

-- Enable smart tab.
vim.opt.smarttab = true

-- Do not expand tabs into spaces.
vim.opt.expandtab = true

-- Width of the tab measured in spaces.
vim.opt.tabstop = 4

-- Number of spaces to use for each auto-indent.
vim.opt.shiftwidth = 4

-- Stop before adding a tab, if tab is larger.
vim.opt.softtabstop = 4

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default.
vim.opt.signcolumn = "yes"

-- Set swap update time (ms).
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = {
  tab = "\\u2192 ", -- single right arrow and spaces.
  nbsp = "␣", -- non breaking space.
  space = "\\u22c5", -- bullets (dots).
}

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on.
vim.opt.cursorline = true

-- Show the cursor position.
vim.opt.ruler = true

-- Color the 80th column.
vim.opt.colorcolumn = "80"

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set(
  "n",
  "[d",
  vim.diagnostic.goto_prev,
  { desc = "Go to previous [D]iagnostic message" }
)
vim.keymap.set(
  "n",
  "]d",
  vim.diagnostic.goto_next,
  { desc = "Go to next [D]iagnostic message" }
)
vim.keymap.set(
  "n",
  "<leader>e",
  vim.diagnostic.open_float,
  { desc = "Show diagnostic [E]rror messages" }
)
vim.keymap.set(
  "n",
  "<leader>q",
  vim.diagnostic.setloclist,
  { desc = "Open diagnostic [Q]uickfix list" }
)

-- Alternative terminal exit (not working in every shell).
-- Default is <C-\><C-n>.
vim.keymap.set(
  "t",
  "<Esc><Esc>",
  "<C-\\><C-n>",
  { desc = "Exit terminal mode" }
)

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup(
    "kickstart-highlight-yank",
    { clear = true }
  ),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
-- See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim.

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
-- NOTE: Here is where you install your plugins.

-- To check the current status of your plugins, run `:Lazy`
-- To update plugins, run `:Lazy update`
require("lazy").setup({
  -- NOTE: Plugins can be added with a link,
  -- or for a github repo: 'owner/repo' link.

  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.

  -- Use `opts = {}` to force a plugin to be loaded.

  -- "gc" to comment visual regions/lines
  -- Below is equivalent to require('Comment').setup({})
  { "numToStr/Comment.nvim", opts = {} },

  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })

  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.

  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.

  -- For example, in the following configuration, we use: event = 'VimEnter'

  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).

  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of
    -- that colorscheme is.

    -- If you want to see what colorschemes are already
    -- installed, you can use `:Telescope colorscheme`.
    "folke/tokyonight.nvim",
    priority = 1000, --[[ Make sure to load this before
                         all the other start plugins.
                   --]]
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles,
      -- and you could load any other, such as 'tokyonight-storm',
      -- 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme("tokyonight-night")

      -- You can configure highlights by doing something like:
      vim.cmd.hi("Comment gui=none")
    end,
  },

  -- Highlight todo, notes, etc in comments.
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },

  { -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    event = "VimEnter", -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require("which-key").setup()

      -- Document existing key chains
      require("which-key").register({
        ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
        ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
        ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
        ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
        ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
        ["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
        ["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
      })
      -- visual mode
      require("which-key").register({
        ["<leader>h"] = { "Git [H]unk" },
      }, { mode = "v" })
    end,
  },

  { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require("mini.ai").setup({ n_lines = 500 })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require("mini.surround").setup()

      -- Simple and easy statusline.
      -- You could remove this setup call if you don't like it,
      -- and try some other statusline plugin
      local statusline = require("mini.statusline")
      -- set use_icons to true if you have a Nerd Font
      statusline.setup({ use_icons = vim.g.have_nerd_font })

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return "%2l:%-2v"
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },

  -- [[ Very useful plugins ]]

  -- Fuzzy Finder (files, lsp, etc.)
  require("kickstart.plugins.telescope"),

  -- Installs LS, formatters and other tools.
  -- NOTE: Mason must be loaded before loading lsp tools etc.
  require("kickstart.plugins.mason"),

  -- LSP Configuration & Plugins.
  require("kickstart.plugins.lsp"),

  -- Autoformat.
  require("kickstart.plugins.autoformat"),

  -- Autocompletion.
  require("kickstart.plugins.autocompletion"),

  -- Highlight, edit, and navigate code.
  require("kickstart.plugins.treesitter"),

  -- Display a navigatable directory tree.
  require("kickstart.plugins.neo-tree"),

  require("kickstart.plugins.debug"),
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins,
  -- configuration, etc from `lua/custom/plugins/*.lua`
  -- This is the easiest way to modularize your config.

  --  See `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  -- [[ Latex ]]
  -- require("custom.plugins.latex")
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will
    -- use the default lazy.nvim defined Nerd Font icons, otherwise define
    -- a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
