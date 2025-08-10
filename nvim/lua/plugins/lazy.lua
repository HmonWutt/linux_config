return {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000, 
    config = function()
      vim.cmd("colorscheme catppuccin-macchiato")
    end 
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  -- File tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    config = function()
      require("nvim-tree").setup({})
    end,
  },
  -- Treesitter for better syntax highlighting and parsing
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "python", "lua", "vim", "vimdoc", "query", "javascript", "html", "css", "json", "yaml", "toml", "bash" },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },
  { 'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      vim.opt.termguicolors = true
      require("bufferline").setup{}
    end
  },
  {
    "ThePrimeagen/vim-be-good",
    cmd = "VimBeGood",
  },
  {
    "terrortylor/nvim-comment",
    config = function()
      require('nvim_comment').setup({
        marker_padding = true,
        comment_empty = true,
        create_mappings = true,
        line_mapping = "gcc",
        operator_mapping = "gc",
        comment_chunk_text_object = "ic",
      })
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        direction = "horizontal",
        size = 15,
      })
    end,
  },
  -- LSP Zero configuration
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'L3MON4D3/LuaSnip' },
      { 'hrsh7th/cmp-nvim-lsp' }, -- Added for LSP completions
      { 'hrsh7th/cmp-buffer' }, -- Added for buffer completions
      { 'hrsh7th/cmp-path' }, -- Added for path completions
      { 'saadparwaiz1/cmp_luasnip' }, -- Added for snippet completions
    },
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_cmp()
      local cmp = require('cmp')
      local cmp_action = lsp_zero.cmp_action()
      cmp.setup({
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        }),
        formatting = lsp_zero.cmp_format({ details = true }),
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
          -- Added for easier completion
          ['<Tab>'] = cmp_action.tab_complete(),
          ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
      })
    end
  },
  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()
      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })
      end)
      require('mason-lspconfig').setup({
        ensure_installed = { 'basedpyright' }, -- Added basedpyright to auto-install
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
          end,
          -- Added basedpyright handler with virtual environment detection
          basedpyright = function()
            require('lspconfig').basedpyright.setup({
              settings = {
                basedpyright = {
                  analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "workspace",
                    useLibraryCodeForTypes = true,
                    typeCheckingMode = "basic",
                  },
                },
              },
              on_init = function(client)
                -- Try to detect virtual environment
                local venv = os.getenv("VIRTUAL_ENV")
                if venv then
                  client.config.settings.python = {
                    pythonPath = venv .. "/bin/python"
                  }
                end
              end,
            })
          end,
        }
      })
    end
  },

  { 
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "mfussenegger/nvim-dap-python",
      "nvim-neotest/nvim-nio", -- Required for dap-ui
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Enhanced DAP UI setup
      dapui.setup({
        controls = {
          element = "repl",
          enabled = true,
        },
        layouts = {
          {
            elements = {
              -- Breakpoints panel - now at top
              {
                id = "breakpoints",
                size = 0.1, -- 10% of left panel
              },
              -- Stacks panel - second from top
              {
                id = "stacks",
                size = 0.1, -- 10% of left panel
              },
              -- Watches panel - third
              {
                id = "watches",
                size = 0.35, -- 35% of left panel
              },
              -- Scopes panel - largest and at bottom
              {
                id = "scopes",
                size = 0.45, -- 45% of left panel
              },
            },
            size = 60, -- Width of left panel (characters)
            position = "left",
          },
          {
            elements = {
              {
                id = "console",
                size = 0.7, -- 70% of bottom panel width
              },
              {
                id = "repl", 
                size = 0.3, -- 30% of bottom panel width
              },
            },
            size = 15, -- Height of bottom panel
            position = "bottom",
          },
        },
      })

      -- Simplified virtual text setup for inline variable display
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = true,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        clear_on_continue = false,
        -- Use end of line position for better compatibility
        virt_text_pos = 'eol',
        all_frames = false,
        virt_lines = false,
        virt_text_win_col = nil,
      })

      -- Setup Python debugging with better configuration
      require('dap-python').setup(vim.fn.expand('~/.venvs/nvim/bin/python'))

      -- Enhanced Python configuration for better debugging with integrated terminal
      table.insert(dap.configurations.python, {
        type = 'python',
        request = 'launch',
        name = 'Launch file (with integrated terminal)',
        program = '${file}',
        console = 'integratedTerminal',
        internalConsoleOptions = 'openOnSessionStart',
        cwd = '${workspaceFolder}',
        justMyCode = false, -- This allows stepping into library code
        showReturnValue = true,
        -- Ensure terminal integration works
        stopOnEntry = false,
        runInTerminal = true,
      })

      -- Auto open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Debugging keymaps
      vim.keymap.set('n', '<F5>', dap.continue, { desc = "Continue" })
      vim.keymap.set('n', '<F10>', dap.step_over, { desc = "Step Over" })
      vim.keymap.set('n', '<F11>', dap.step_into, { desc = "Step Into" })
      vim.keymap.set('n', '<F12>', dap.step_out, { desc = "Step Out" })
      vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set('n', '<Leader>B', function()
        dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
      end, { desc = "Conditional Breakpoint" })
      vim.keymap.set('n', '<Leader>dr', dap.repl.open, { desc = "Open REPL" })
      vim.keymap.set('n', '<Leader>du', dapui.toggle, { desc = "Toggle Debug UI" })

      -- Additional helpful keymaps for variable inspection
      vim.keymap.set('n', '<Leader>dh', function()
        require('dap.ui.widgets').hover()
      end, { desc = "DAP Hover" })

      vim.keymap.set('n', '<Leader>dp', function()
        require('dap.ui.widgets').preview()
      end, { desc = "DAP Preview" })

      -- Toggle virtual text on/off
      vim.keymap.set('n', '<Leader>dt', function()
        require('nvim-dap-virtual-text').toggle()
      end, { desc = "Toggle Virtual Text" })

      -- Evaluate expression under cursor
      vim.keymap.set({ 'n', 'v' }, '<Leader>de', function()
        require('dapui').eval()
      end, { desc = "Evaluate Expression" })
    end,
  },
}
