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

-- Custom file associations.
local function assocFiletype(patt, ft)
  vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    desc = "Associate .FCMacro files with python.",
    group = vim.api.nvim_create_augroup("fcmacro-file-assoc", { clear = true }),
    pattern = patt,
    command = "set filetype=" .. ft,
  })
end

assocFiletype("*.FCMacro", "python")
