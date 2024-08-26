LazyConform = {
  "stevearc/conform.nvim",
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
      -- Conform can also run multiple formatters sequentially
      python = { "ruff_format", "ruff_organize_imports" },

      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      -- javascript = { { "prettierd", "prettier" } },
      javascript = { "prettier" },
      c = { "clang-format" },
      bash = { "shfmt" },
      sh = { "shfmt" },
      markdown = { "prettier" },
    },
  },
}

-- Custom configuration.
Formatters = {
  ruff_format = {},
  ruff_organize_imports = {},
  prettier = {},
}

-- Ruff config.
Ruff_config = {
  append_args = {
    "--config",
    'extend-include = ["*.FCMacro"]', -- add support for FreeCAD macros.
  },
}

Formatters.ruff_format.append_args = Ruff_config.append_args
Formatters.ruff_organize_imports.append_args = Ruff_config.append_args

Formatters.prettier = {
  options = {
    -- Set to true to ignore errors
    ignore_errors = false,
    -- Map of treesitter language to file extension
    -- A temporary file name with this extension will be generated during
    -- formatting because some formatters care about the filename.
    lang_to_ext = {
      bash = "sh",
      c_sharp = "cs",
      elixir = "exs",
      javascript = "js",
      julia = "jl",
      latex = "tex",
      markdown = "md",
      python = "py",
      ruby = "rb",
      rust = "rs",
      teal = "tl",
      typescript = "ts",
    },
    -- Map of treesitter language to formatters to use
    -- (defaults to the value from formatters_by_ft)
    lang_to_formatters = {},
  },
}

LazyConform.formatters = Formatters

return LazyConform
