-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
    theme = "catppuccin",

    hl_override = {
        Comment = { italic = true },
        ["@comment"] = { italic = true },
    },
}

M.ui = {
    cmp = {
        icons = true,
        lspkind_text = true,
    },

    statusline = {
        theme = "vscode_colored",
        separator_style = "block",
        enabled = true,
    },

    tabufline = {
        order = { "treeOffset", "buffers", "tabs", "btns", "abc" },
        modules = {
            abc = function()
                return "hi"
            end,
        },
    },
}

M.nvdash = {
    load_on_startup = true,

    header = {
        "                            ",
        "     ▄▄         ▄ ▄▄▄▄▄▄▄   ",
        "   ▄▀███▄     ▄██ █████▀    ",
        "   ██▄▀███▄   ███           ",
        "   ███  ▀███▄ ███           ",
        "   ███    ▀██ ███           ",
        "   ███      ▀ ███           ",
        "   ▀██ █████▄▀█▀▄██████▄    ",
        "     ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀   ",
        "                            ",
        "     Powered By eovim    ",
        "                            ",
    },

    buttons = {
        { txt = "  Find File", keys = "Spc f f", cmd = "Telescope find_files" },
        { txt = "  Recent Files", keys = "Spc f o", cmd = "Telescope oldfiles" },
        { txt = "  Themes", keys = "Spc t h", cmd = "Telescope themes" },
        { txt = "  Mappings", keys = "Spc c h", cmd = "NvCheatsheet" },
        -- more... check nvconfig.lua file for full list of buttons
    },
}

M.colorify = {
    enabled = true,
    mode = "virtual",
    virt_text = "󱓻 ",
    highlight = { hex = true, lspvars = true },
}

return M
