require("config.lazy")
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.clipboard = "unnamedplus"

vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "reload source" })
