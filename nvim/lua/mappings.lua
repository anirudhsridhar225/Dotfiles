require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- DAP UI
map("n", "<F1>", "<cmd>lua require('dapui').toggle()<CR>", { desc = "DAP UI" })
map("n", "<F10>", "<cmd>lua require('dap').step_over()<CR>", { desc = "DAP Step Over" })
map("n", "<F11>", "<cmd>lua require('dap').step_into()<CR>", { desc = "DAP Step Into" })
map("n", "<F12>", "<cmd>lua require('dap').step_out()<CR>", { desc = "DAP Step Out" })
map("n", "<F5>", "<cmd>lua require('dap').continue()<CR>", { desc = "DAP Continue" })
map("n", "<F6>", "<cmd>lua require('dap').down()<CR>", { desc = "DAP Down Stack" })
map("n", "<F7>", "<cmd>lua require('dap').up()<CR>", { desc = "DAP Up Stack" })
map("n", "<F8>", "<cmd>lua require('dap').run_to_cursor()<CR>", { desc = "DAP Run To Cursor" })
map("n", "<F2>", "<cmd>lua require('dap').terminate()<CR>", { desc = "DAP Terminate" })
map("n", "<F9>", "<cmd> DapToggleBreakpoint <CR>", { desc = "DAP Add breakpoint" })

-- Build shortcuts
map("n", "<c-X>", "<cmd> !bear -- make <CR>", { noremap = true, desc = "Build using bear -- make" })
map("n", "<c-Z>", "<cmd> !make clean <CR>", { noremap = true, desc = "Clean using make clean" })
