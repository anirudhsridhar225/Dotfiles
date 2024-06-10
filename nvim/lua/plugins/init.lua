return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" }, -- uncomment for format on save
    config = function()
      local conform = require "conform"

      conform.setup {
        formatters_by_ft = {
          lua = { "stylua" },
          css = { "prettier" },
          html = { "prettier" },
          javascript = { "prettier" },
          cpp = { "clang-format" },
          python = { "isort", "autopep8" },
        },

        format_on_save = {
          timeout_ms = 500,
          async = false,
          lsp_fallback = true,
        },
      }
    end,
  },
  {
    "mfussenegger/nvim-dap",
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    event = "VeryLazy",
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.after.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.after.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "clangd",
        "clang-format",
        "codelldb",
        "nvim-nio",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "cpp",
        "c",
      },
    },
  },
}
