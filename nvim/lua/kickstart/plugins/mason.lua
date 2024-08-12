return {
  "williamboman/mason.nvim",

  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },

  config = function()
    require("mason").setup()

    -- LS.
    require("mason-lspconfig").setup({
      automatic_installation = true,
      ensure_installed = {
        "clangd",
        "bashls",
        "pyright",
      },
    })

    -- Formatters.
    require("mason-tool-installer").setup({
      ensure_installed = {
        "stylua", -- Used to format Lua code.
        "ruff", -- Used to format Python code.
        "clang-format", -- Used to format C/C++ code.
        "shfmt", -- Used to format sh and bash code.
        "prettier", -- Used to format markdown, js, ts, html, css
      },
    })
  end,
}
