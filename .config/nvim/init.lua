--
--
-- [[ Globals ]]
--
--
-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
-- disable netrw since we use neotree
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
-- vim.g.clipboard = {
--   name = 'xsel',
--   copy = {
--     ['+'] = 'xsel --nodetach -i -b',
--     ['*'] = 'xsel --nodetach -i -p',
--   },
--   paste = {
--     ['+'] = 'xsel -o -b',
--     ['*'] = 'xsel -o -b',
--   },
--   cache_enabled = 1,
-- }
--
--
-- [[ Options ]]
--
--
-- Make line numbers default
vim.o.number = true
-- vim.o.relativenumber = true
-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'
-- Don't show the mode, since it's already in the status line
vim.o.showmode = false
-- Sync clipboard between OS and Neovim. Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
-- Enable break indent
vim.o.breakindent = true
-- Save undo history
vim.o.undofile = true
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true
-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'
-- Decrease update time
vim.o.updatetime = 250
-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300
-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true
-- Sets how neovim will display certain whitespace characters in the editor.
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'
-- Show which line your cursor is on
vim.o.cursorline = true
-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10
-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
vim.o.confirm = true
-- Better tab formatting
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.bo.softtabstop = 2
--
--
-- [[ Basic Keymaps ]]
--
--
-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
-- Exit terminal mode in the builtin terminal with an easier shortcut
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
vim.keymap.set('n', '<C-S-h>', '<C-w>H', { desc = 'Move window to the left' })
vim.keymap.set('n', '<C-S-l>', '<C-w>L', { desc = 'Move window to the right' })
vim.keymap.set('n', '<C-S-j>', '<C-w>J', { desc = 'Move window to the lower' })
vim.keymap.set('n', '<C-S-k>', '<C-w>K', { desc = 'Move window to the upper' })
-- ctrl+s to save
vim.keymap.set({ 'n', 'i', 'v' }, '<C-s>', '<cmd> w <cr>')
-- Show error in float
vim.keymap.set('n', '<leader>e', function()
  vim.diagnostic.open_float { focusable = true }
  vim.diagnostic.open_float { focusable = true }
end, { desc = 'Show [E]rror' })
-- Close float on <Esc>
vim.keymap.set('n', '<Esc>', function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative == 'win' then
      vim.api.nvim_win_close(win, false)
    end
  end
end, { desc = 'Close opened float window' })
-- show type hint in a hover window
vim.keymap.set('n', '<leader>sth', function()
  vim.lsp.buf.hover { border = 'single' }
end, { desc = '[S]how [T]ype [H]int' })
-- rename
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[N]ame' })
-- code action
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })
vim.keymap.set('n', '<leader>ba', function()
  vim.lsp.buf.code_action {
    context = {
      only = { 'source.fixAll.biome' },
      diagnostics = {},
    },
    apply = true,
  }
end, { desc = '[B]iome [A]ctions' })
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Spectre"
})
vim.keymap.set('n', '<leader>ssw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
    desc = "Search current word"
})
vim.keymap.set('v', '<leader>ssw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = "Search current word"
})
vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
    desc = "Search on current file"
})
--
--
-- [[ Plugin Keymaps ]]
--
--
-- Lazy git
vim.keymap.set('n', '<leader>lg', function()
  Snacks.lazygit()
end, { desc = '[L]azy [G]it' })
vim.keymap.set('n', '<leader>llg', function()
  Snacks.lazygit()
end, { desc = '[L]ocal Dir [L]azy [G]it' })
-- Explorer
vim.keymap.set('n', '\\', function()
  Snacks.explorer()
end, { desc = 'Open file explorer' })
-- Picker
vim.keymap.set('n', '<leader>so', function()
  Snacks.picker.smart()
end, { desc = '[S]mart [O]pen' })
vim.keymap.set('n', '<leader>sf', function()
  Snacks.picker.files()
end, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sn', function()
  Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })
vim.keymap.set('n', '<leader>sb', function()
  Snacks.picker.buffers()
end, { desc = '[S]earch [B]uffers' })
vim.keymap.set('n', '<leader>sg', function()
  Snacks.picker.grep {
    args = { '--no-ignore' },
  }
end, { desc = '[S]earch [G]rep' })
vim.keymap.set('n', '<leader>s/', function()
  Snacks.picker.grep {
    dirs = { vim.fn.expand '%:p' },
  }
end, { desc = '[S]earch current file' })
vim.keymap.set('n', '<leader>sgb', function()
  Snacks.picker.grep_buffers()
end, { desc = '[S]earch [G]rep [B]uffers' })
vim.keymap.set('n', '<leader>sgw', function()
  Snacks.picker.grep_word()
end, { desc = '[S]earch [G]rep [W]ord' })
vim.keymap.set('n', '<leader>sd', function()
  Snacks.picker.diagnostics()
end, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sh', function()
  Snacks.picker.help()
end, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', function()
  Snacks.picker.keymaps()
end, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sr', function()
  Snacks.picker.resume()
end, { desc = '[S]earch [R]esume' })
-- LSP Pickers
vim.keymap.set('n', '<leader>gd', function()
  Snacks.picker.lsp_definitions()
end, { desc = '[G]oto [D]efinitions' })
vim.keymap.set('n', '<leader>gD', function()
  Snacks.picker.lsp_definitions()
end, { desc = '[G]oto [D]eclarations' })
vim.keymap.set('n', '<leader>gr', function()
  Snacks.picker.lsp_references()
end, { desc = '[G]oto [R]eferences' })
vim.keymap.set('n', '<leader>gi', function()
  Snacks.picker.lsp_implementations()
end, { desc = '[G]oto [I]mplementations' })
vim.keymap.set('n', '<leader>gt', function()
  Snacks.picker.lsp_type_definitions()
end, { desc = '[G]oto [T]ype Definitions' })
vim.keymap.set('n', '<leader>ss', function()
  Snacks.picker.lsp_symbols()
end, { desc = '[S]earch [S]ymbols' })
vim.keymap.set('n', '<leader>sw', function()
  Snacks.picker.lsp_workspace_symbols()
end, { desc = '[S]earch [W]orkspace Symbols' })
-- Flash
vim.keymap.set('n', '<leader>fl', function()
  require('flash').jump()
end, { desc = '[F]lash' })
-- Mini-trailspace
vim.keymap.set('n', '<leader>tw', function()
  require('mini.trailspace').trim()
end, { desc = '[T]rim [W]hitespace' })
vim.keymap.set('n', '<leader>tl', function()
  require('mini.trailspace').trim_last_lines()
end, { desc = '[T]rim [L]ast lines' })
-- Aerial
vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>', { desc = '[A]erial' })
-- Conform
vim.keymap.set('n', '<leader>f', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = '[F]ormat buffer' })
--
--
-- [[ Basic Autocommands ]]
--
--
-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
-- Update prettierd on prettier config update
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  group = vim.api.nvim_create_augroup('RestartPrettierd', { clear = true }),
  pattern = '*prettier*',
  callback = function()
    vim.fn.system 'prettierd restart'
  end,
})
--
--
-- [[ Install `lazy.nvim` plugin manager ]]
--
--
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)
--
--
-- [[ LSP setup ]]
--
--
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
}
--
--
-- [[ Configure and install plugins ]]
--
--
require('lazy').setup({
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically
  'folke/flash.nvim', -- Helpful navigation util
  'chrisgrieser/nvim-early-retirement', -- Close buffers after 20 mins
  'wakatime/vim-wakatime', -- Wakatime
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'neovim/nvim-lspconfig',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
      -- formatters
      require('mason-tool-installer').setup {
        ensure_installed = {
          'prettierd',
          'prettier',
        },
      }
      -- lsps
      require('mason-lspconfig').setup {
        automatic_enable = true,
        ensure_installed = { 'ruff', 'basedpyright', 'vtsls', 'gopls', 'rust_analyzer', 'tailwindcss', 'biome' },
      }
      vim.lsp.enable {
        'ruff',
        'basedpyright',
        'vtsls',
        'gopls',
        'rust_analyzer',
        'tailwindcss',
        'biome',
      }
      vim.lsp.config('vtsls', {
        settings = {
          typescript = {
            tsserver = {
              maxTsServerMemory = 10000
            }
          }
        }
      })
    end,
  },
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  { -- Display lsp status
    'j-hui/fidget.nvim',
    opts = {
      -- options
    },
  },
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      delay = 0,
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },
      -- Document existing key chains
      spec = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },
  -- Group of useful plugins
  {
    'folke/snacks.nvim',
    config = function()
      require('snacks').setup {
        -- Disables LSPs for large files
        bigfile = {},
        -- Visual indent guides
        indent = {},
        -- Better input
        input = {},
        -- Lazygit
        lazygit = {},
        -- Versatile picker popup
        picker = {
          exclude = { 'node_modules', '.git', '_build', 'target', '.sst', 'dist', '.wrangler', 'llm-repos', '.browser-profiles' },
          hidden = true,
          ignored = true,
          sources = {
            files = {
              hidden = true,
              ignored = true,
            },
            explorer = {
              auto_close = true,
              layout = {
                preset = 'default',
                preview = true,
              },
            },
          },
        },
        -- File explorer
        explorer = {},
      }
    end,
  },
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }
      -- Move text in direction with alt + hjkl
      require('mini.move').setup()
      -- Auto add matching bracket pairs
      require('mini.pairs').setup()
      -- Trim trailing whitespace (with keybinds)
      require('mini.trailspace').setup {
        only_in_normal_buffers = true,
      }
      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()
      -- Simple and easy statusline.
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }
      -- set the section for cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },
  { -- Much better Lua LSP
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  -- { -- Main LSP Configuration
  --   'neovim/nvim-lspconfig',
  --   dependencies = {
  --     -- Automatically install LSPs and related tools to stdpath for Neovim
  --     -- Mason must be loaded before its dependents so we need to set it up here.
  --     -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
  --     { 'mason-org/mason.nvim', opts = {} },
  --     'mason-org/mason-lspconfig.nvim',
  --     'WhoIsSethDaniel/mason-tool-installer.nvim',
  --
  --     -- Useful status updates for LSP.
  --     { 'j-hui/fidget.nvim', opts = {} },
  --
  --     -- Allows extra capabilities provided by blink.cmp
  --     'saghen/blink.cmp',
  --   },
  --   config = function()
  --     vim.api.nvim_create_autocmd('LspAttach', {
  --       group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  --       callback = function(event)
  --         -- NOTE: Remember that Lua is a real programming language, and as such it is possible
  --         -- to define small helper and utility functions so you don't have to repeat yourself.
  --         --
  --         -- In this case, we create a function that lets us more easily define mappings specific
  --         -- for LSP related items. It sets the mode, buffer and description for us each time.
  --         local map = function(keys, func, desc, mode)
  --           mode = mode or 'n'
  --           vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
  --         end
  --
  --         -- Rename the variable under your cursor.
  --         --  Most Language Servers support renaming across files, etc.
  --         map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
  --
  --         -- Execute a code action, usually your cursor needs to be on top of an error
  --         -- or a suggestion from your LSP for this to activate.
  --         map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
  --
  --         -- -- Find references for the word under your cursor.
  --         -- map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  --         --
  --         -- -- Jump to the implementation of the word under your cursor.
  --         -- --  Useful when your language has ways of declaring types without an actual implementation.
  --         -- map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  --         --
  --         -- -- Jump to the definition of the word under your cursor.
  --         -- --  This is where a variable was first declared, or where a function is defined, etc.
  --         -- --  To jump back, press <C-t>.
  --         -- map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  --         --
  --         -- -- WARN: This is not Goto Definition, this is Goto Declaration.
  --         -- --  For example, in C this would take you to the header.
  --         -- map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  --         --
  --         -- -- Fuzzy find all the symbols in your current document.
  --         -- --  Symbols are things like variables, functions, types, etc.
  --         -- map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
  --         --
  --         -- -- Fuzzy find all the symbols in your current workspace.
  --         -- --  Similar to document symbols, except searches over your entire project.
  --         -- map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
  --         --
  --         -- -- Jump to the type of the word under your cursor.
  --         -- --  Useful when you're not sure what type a variable is and you want to see
  --         -- --  the definition of its *type*, not where it was *defined*.
  --         -- map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')
  --
  --         -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
  --         ---@param client vim.lsp.Client
  --         ---@param method vim.lsp.protocol.Method
  --         ---@param bufnr? integer some lsp support methods only in specific files
  --         ---@return boolean
  --         local function client_supports_method(client, method, bufnr)
  --           if vim.fn.has 'nvim-0.11' == 1 then
  --             return client:supports_method(method, bufnr)
  --           else
  --             return client.supports_method(method, { bufnr = bufnr })
  --           end
  --         end
  --
  --         -- The following two autocommands are used to highlight references of the
  --         -- word under your cursor when your cursor rests there for a little while.
  --         --    See `:help CursorHold` for information about when this is executed
  --         --
  --         -- When you move your cursor, the highlights will be cleared (the second autocommand).
  --         local client = vim.lsp.get_client_by_id(event.data.client_id)
  --         if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
  --           local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
  --           vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
  --             buffer = event.buf,
  --             group = highlight_augroup,
  --             callback = vim.lsp.buf.document_highlight,
  --           })
  --
  --           vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
  --             buffer = event.buf,
  --             group = highlight_augroup,
  --             callback = vim.lsp.buf.clear_references,
  --           })
  --
  --           vim.api.nvim_create_autocmd('LspDetach', {
  --             group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
  --             callback = function(event2)
  --               vim.lsp.buf.clear_references()
  --               vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
  --             end,
  --           })
  --         end
  --
  --         -- The following code creates a keymap to toggle inlay hints in your
  --         -- code, if the language server you are using supports them
  --         --
  --         -- This may be unwanted, since they displace some of your code
  --         if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
  --           map('<leader>th', function()
  --             vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
  --           end, '[T]oggle Inlay [H]ints')
  --         end
  --       end,
  --     })
  --
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- You can use 'stop_after_first' to run the first available formatter from the list
        typescript = { 'biome', 'biome-organize-imports', 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'biome', 'biome-organize-imports', 'prettierd', 'prettier', stop_after_first = true },
      },
    },
  },
  { 'L3MON4D3/LuaSnip', keys = {} },
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    version = '*',
    config = function()
      require('blink.cmp').setup {
        snippets = { preset = 'luasnip' },
        signature = { enabled = true },
        appearance = {
          use_nvim_cmp_as_default = false,
          nerd_font_variant = 'normal',
        },
        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer' },
          providers = {
            cmdline = {
              min_keyword_length = 2,
            },
          },
        },
        keymap = {
          ['<C-f>'] = {},
        },
        cmdline = {
          enabled = false,
          completion = { menu = { auto_show = true } },
          keymap = {
            ['<CR>'] = { 'accept_and_enter', 'fallback' },
          },
        },
        completion = {
          menu = {
            border = nil,
            scrolloff = 1,
            scrollbar = false,
            draw = {
              columns = {
                { 'kind_icon' },
                { 'label', 'label_description', gap = 1 },
                { 'kind' },
                { 'source_name' },
              },
            },
          },
          documentation = {
            window = {
              border = nil,
              scrollbar = false,
              winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
            },
            auto_show = true,
            auto_show_delay_ms = 500,
          },
        },
      }

      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        transparent = true,
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
      }

      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'
    end,
    -- 'sainnhe/gruvbox-material',
    -- priority = 1000,
    -- config = function()
    --   vim.g.gruvbox_material_enable_italic = true
    --   vim.cmd.colorscheme 'gruvbox-material'
    -- end,
    -- 'neanias/everforest-nvim',
    -- version = false,
    -- lazy = false,
    -- priority = 1000, -- make sure to load this before all the other start plugins
    -- config = function()
    --   require('everforest').setup {
    --     transparent_background_level = 0,
    --   }
    --   vim.cmd.colorscheme 'everforest'
    -- end,
  },
  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'tsx',
        'typescript',
      },
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
  {
    'stevearc/aerial.nvim',
    -- Optional dependencies
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      highlight_on_hover = true,
      autojump = true,
    },
  },
  {
    'folke/ts-comments.nvim',
    opts = {},
    event = 'VeryLazy',
    enabled = vim.fn.has 'nvim-0.10.0' == 1,
  },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup {
        opts = {
          -- Defaults
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        },
        -- Also override individual filetype configs, these take priority.
        -- Empty by default, useful if one of the "opts" global settings
        -- doesn't work well in a specific filetype
        per_filetype = {
          ['html'] = {
            enable_close = false,
          },
        },
      }
    end,
  },
  {
    'elixir-tools/elixir-tools.nvim',
    version = '*',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local elixir = require 'elixir'
      local elixirls = require 'elixir.elixirls'

      elixir.setup {
        nextls = { enable = true },
        elixirls = {
          enable = true,
          settings = elixirls.settings {
            dialyzerEnabled = false,
            enableTestLenses = false,
          },
          on_attach = function(client, bufnr)
            vim.keymap.set('n', '<space>fp', ':ElixirFromPipe<cr>', { buffer = true, noremap = true })
            vim.keymap.set('n', '<space>tp', ':ElixirToPipe<cr>', { buffer = true, noremap = true })
            vim.keymap.set('v', '<space>em', ':ElixirExpandMacro<cr>', { buffer = true, noremap = true })
          end,
        },
        projectionist = {
          enable = true,
        },
      }
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  {
    'gelguy/wilder.nvim',
    config = function()
      local wilder = require 'wilder'
      wilder.setup { modes = { ':', '/', '?' } }

      wilder.set_option(
        'renderer',
        wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
          highlights = {
            border = 'Normal', -- highlight to use for the border
          },
          -- 'single', 'double', 'rounded' or 'solid'
          -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
          border = 'rounded',
        })
      )
    end,
  },
  {
    'dmmulroy/ts-error-translator.nvim',
    config = function()
      require('ts-error-translator').setup {
        -- Auto-attach to LSP servers for TypeScript diagnostics (default: true)
        auto_attach = true,

        -- LSP server names to translate diagnostics for (default shown below)
        servers = {
          'astro',
          -- 'svelte',
          -- 'ts_ls',
          -- 'tsserver', -- deprecated, use ts_ls
          -- 'typescript-tools',
          -- 'volar',
          'vtsls',
        },
      }
    end,
  },
  {
    'nvim-pack/nvim-spectre',
    config = function()
      require('spectre').setup()
    end
  }
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
