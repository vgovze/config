-- Set <space> as the leader key. See `:help mapleader`.
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
