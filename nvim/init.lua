-- Provided by TJ De Vries (Kickstart neovim).

-- [[ Basic setup ]]
--  NOTE: Must happen before plugins are loaded.
require("custom.basic-setup")

-- [[ Custom additional configuration ]]
require("custom.keymaps")
require("custom.autocommands")

-- [[ Install `lazy.nvim` plugin manager ]]
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

-- To check the current status of your plugins, run `:Lazy`
-- To update plugins, run `:Lazy update`
require("lazy").setup({
  -- NOTE: Plugins can be added with a link,
  -- or for a github repo: 'owner/repo' link.

  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.

  -- Use `opts = {}` to force a plugin to be loaded.

  -- "gc" to comment visual regions/lines
  { "numToStr/Comment.nvim", opts = {} },
  -- Same as require('Comment').setup({})

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.

  -- Colorscheme.
  { -- If you want to see what colorschemes are already
    -- installed, you can use `:Telescope colorscheme`.
    "folke/tokyonight.nvim",

    -- Load before all other plugins.
    priority = 1000,

    init = function()
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

  -- In the following configuration, we use: event = 'VimEnter'
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).

  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --   config = function() ... end

  -- Show keybinds in a window.
  {
    "folke/which-key.nvim",
    event = "VimEnter", -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require("which-key").setup()

      -- Group keys beginning with the same key chain.
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

  {
    "echasnovski/mini.nvim",
    config = function()
      -- Better Around/Inside textobjects
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require("mini.ai").setup({ n_lines = 500 })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require("mini.surround").setup()

      -- Simple and easy statusline.
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
    end,
  },

  -- Mason. Required for LSP, Formatters etc.
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup() -- Init Mason.
    end,
  },

  -- Install language servers using mason.
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = {
          "clangd",
          "bashls",
          "pyright",
          "arduino_language_server",
          "lua_ls",
        },
      })
    end,
  },

  -- Install formatters and other tooling using Mason.
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "stylua", -- Used to format Lua code.
          "ruff", -- Used to format Python code.
          "clang-format", -- Used to format C/C++ code.
          "shfmt", -- Used to format sh and bash code.
          "prettier", -- Used to format markdown, js, ts, html, css
        },
      })
    end
  },

  -- Fuzzy Finder (files, lsp, etc.)
  require("kickstart.plugins.telescope"),

  -- Highlight, edit, and navigate code.
  require("kickstart.plugins.treesitter"),

  -- Autocompletion.
  require("kickstart.plugins.autocompletion"),

  -- Display a navigatable directory tree.
  require("kickstart.plugins.neo-tree"),

  -- LSP Configuration & Plugins.
  require("kickstart.plugins.lsp"),

  -- Autoformat.
  require("kickstart.plugins.autoformat"),

  -- require 'kickstart.plugins.lint',

  -- require("kickstart.plugins.debug"),

  -- See `:help gitsigns` to understand what the configuration keys do
  require("kickstart.plugins.gitsigns"),

  --  See `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  require("custom.plugins.bigfiles"),
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
