return {
  "stevearc/conform.nvim",
  lazy = false,
  dependencies = {
    { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "[F]ormat buffer",
    },
  },
  config = function()
    local formatters = {
      "stylua", -- Used to format Lua code.
      "ruff", -- Used to format Python code.
      "clang-format", -- Used to format C/C++ code.
    }
    require("mason-tool-installer").setup({
      ensure_installed = formatters,
    })
  end,
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff-format", "ruff_organize_import" },

      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },

      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      -- javascript = { { "prettierd", "prettier" } },
    },
  },
}
