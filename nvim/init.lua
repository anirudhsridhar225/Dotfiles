-- =========================
-- Basic Options
-- =========================
vim.opt.hlsearch = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.cursorline = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.clipboard:append({ "unnamed", "unnamedplus" })

vim.g.mapleader = " "

-- =========================
-- Plugins
-- =========================
vim.pack.add({
    -- Dependencies
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",

    -- Theme
    "https://github.com/folke/tokyonight.nvim",

    -- Treesitter
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },

    -- LSP
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",

    -- Completion
    "https://github.com/hrsh7th/nvim-cmp",
    "https://github.com/hrsh7th/cmp-nvim-lsp",
    "https://github.com/L3MON4D3/LuaSnip",
    "https://github.com/saadparwaiz1/cmp_luasnip",
    "https://github.com/hrsh7th/cmp-buffer",
    "https://github.com/hrsh7th/cmp-path",

    -- Telescope
    "https://github.com/nvim-telescope/telescope.nvim",

    -- File explorer
    "https://github.com/nvim-tree/nvim-tree.lua",

    -- Statusline
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/akinsho/bufferline.nvim",
    "https://github.com/tiagovla/scope.nvim",

    -- Git signs
    "https://github.com/lewis6991/gitsigns.nvim",

    -- Todo comments
    "https://github.com/folke/todo-comments.nvim",

    -- Auto Pairs
    "https://github.com/windwp/nvim-autopairs"
})

-- =========================
-- Colorscheme
-- =========================
vim.cmd.colorscheme("tokyonight-night")

-- =========================
-- Treesitter
-- =========================
require("nvim-treesitter").install({
    "lua",
    "rust",
    "cpp",
    "c",
    "go",
    "python",
    "javascript",
    "typescript",
    "html",
    "css",
    "json",
    "bash",
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        pcall(vim.treesitter.start)
    end,
})

-- =========================
-- Mason
-- =========================
require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "clangd",
        "gopls",
        "pyright",
        "ts_ls",
        "html",
        "cssls",
    },
})

-- =========================
-- Completion
-- =========================
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),

        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),

    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    }),
})

-- =========================
-- Auto Pairs
-- =========================
require("nvim-autopairs").setup()

-- =========================
-- LSP
-- =========================
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

    vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
    end, opts)

    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
end

local servers = {
    "lua_ls",
    "rust_analyzer",
    "clangd",
    "gopls",
    "pyright",
    "ts_ls",
    "html",
    "cssls",
}

for _, server in ipairs(servers) do
    vim.lsp.config(server, {
        capabilities = capabilities,
        on_attach = on_attach,
    })

    vim.lsp.enable(server)
end

-- insert-mode abbreviations
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'py',
  callback = function()
    vim.cmd 'iabbrev _inf float("-inf")'
  end,
})
-- =========================
-- Diagnostics
-- =========================
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

-- =========================
-- Telescope
-- =========================
local telescope = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", telescope.find_files, {})
vim.keymap.set("n", "<leader>fg", telescope.live_grep, {})
vim.keymap.set("n", "<leader>fb", telescope.buffers, {})
vim.keymap.set("n", "<leader>fh", telescope.help_tags, {})
vim.keymap.set("n", "<leader>tt", "<cmd>TodoTelescope<CR>")
vim.keymap.set("n", "<leader>tl", "<cmd>TodoLocList<CR>")
vim.keymap.set("n", "]t", function()
    require("todo-comments").jump_next()
end)

vim.keymap.set("n", "[t", function()
    require("todo-comments").jump_prev()
end)

-- =========================
-- Nvim Tree
-- =========================
require("nvim-tree").setup({
    view = {
        width = 35,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = false,
    },
})

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- =========================
-- Lualine
-- =========================
require("lualine").setup({
    options = {
        theme = "tokyonight",
        section_separators = "",
        component_separators = "",
    },
})

-- =========================
-- Git Signs
-- =========================
require("gitsigns").setup()

-- =========================
-- Bufferline
-- =========================
require("bufferline").setup()

-- =========================
-- Scope
-- =========================
require("scope").setup()

-- =========================
-- Todo comments
-- =========================
require("todo-comments").setup({
    signs = true,

    keywords = {
        FIX = {
            icon = " ",
            color = "error",
        },

        TODO = {
            icon = " ",
            color = "info",
        },

        HACK = {
            icon = " ",
            color = "warning",
        },

        WARN = {
            icon = " ",
            color = "warning",
        },

        PERF = {
            icon = " ",
            color = "default",
        },

        NOTE = {
            icon = " ",
            color = "hint",
        },

        TEST = {
            icon = "⏲ ",
            color = "test",
        },
    },
})

-- =========================
-- Better UI
-- =========================
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- =========================
-- Useful Keymaps
-- =========================
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>")
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>")
vim.keymap.set("n", "<leader>to", ":tabonly<CR>")

vim.keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>")
