return {
  "pteroctopus/faster.nvim",
  opts = {
    behaviour = {
      on = true,
      features_disabled = {
        "illuminate",
        "matchparen",
        "lsp",
        "treesitter",
        "indent_blankline",
        "vimopts",
        "syntax",
        "filetype",
      },
      filesize = 1, -- megabytes.
      pattern = "*", -- megabytes.
    },
  },
}
