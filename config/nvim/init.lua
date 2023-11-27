return require('packer').startup(function(use)
  use "wbthomason/packer.nvim"

  -- Syntax & Colors
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use { "embark-theme/vim", as = "embark" }

  -- Navigation
  use "nvim-lua/plenary.nvim"
  use "nvim-lualine/lualine.nvim"
  use "nvim-telescope/telescope.nvim"
  use "nvim-tree/nvim-tree.lua"
  use "nvim-tree/nvim-web-devicons"

  -- Completion
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "L3MON4D3/LuaSnip"
  use "saadparwaiz1/cmp_luasnip"

  -- LSP
  use "neovim/nvim-lspconfig"

  -- Utils
  use "godlygeek/tabular"
  use "janko-m/vim-test"
  use "tpope/vim-commentary"
  use "tpope/vim-endwise"
  use "tpope/vim-eunuch"
  use "tpope/vim-fugitive"
  use "tpope/vim-projectionist"
  use "tpope/vim-repeat"
  use "tpope/vim-surround"
  use "tpope/vim-unimpaired"

  -----------------------------------------------------------------------------
  -- Leader
  -----------------------------------------------------------------------------

  vim.g.mapleader = " "

  vim.keymap.set("n", "<leader>bd", ":%bd <bar> e#<CR>")
  vim.keymap.set("n", "<leader>ed", ":tabe TODO<CR>")
  vim.keymap.set("n", "<leader>md", ":!open -a /Applications/Marked\\ 2.app %<CR>")

  -----------------------------------------------------------------------------
  -- Display & Whitespace
  -----------------------------------------------------------------------------

  vim.opt.copyindent = true
  vim.opt.expandtab = true
  vim.opt.hidden = true
  vim.opt.number = true
  vim.opt.numberwidth = 3
  vim.opt.ruler = true
  vim.opt.shiftwidth = 2
  vim.opt.showbreak = "…"
  vim.opt.showcmd = true
  vim.opt.softtabstop = 2
  vim.opt.tabstop = 2
  vim.opt.textwidth = 98

  vim.wo.wrap = false
  vim.wo.linebreak = true

  -----------------------------------------------------------------------------
  -- Colorscheme
  -----------------------------------------------------------------------------

  vim.o.termguicolors = true
  vim.cmd.colorscheme("embark")

  require("lualine").setup({
    options = {
      theme = "auto"
    }
  })

  -----------------------------------------------------------------------------
  -- Remap escape
  -----------------------------------------------------------------------------

  vim.cmd([[
    inoremap kj <esc>
    vnoremap kj <esc>
    cnoremap kj <C-C>
  ]])

  -----------------------------------------------------------------------------
  -- Search
  -----------------------------------------------------------------------------

  local builtin = require("telescope.builtin")
  vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
  vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
  vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
  vim.keymap.set("n", "<leader>fc", builtin.git_commits, {})
  vim.keymap.set("n", "<leader>fa", builtin.resume, {})
  vim.keymap.set("n", "<leader>fG", ":execute 'Telescope grep_string search='.expand('<cword>')<CR>", {})

  -----------------------------------------------------------------------------
  -- File Tree
  -----------------------------------------------------------------------------

  -- Disable netrw for nvim-tree
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  require("nvim-tree").setup({
    sort_by = "case_sensitive",
    filters = {
      dotfiles = true
    },
    view = {
      side = "right"
    }
  })

  local ntree = require("nvim-tree.api")

  vim.keymap.set("n", "<leader>fd", ntree.tree.toggle, {})

  -----------------------------------------------------------------------------
  -- Testing
  -----------------------------------------------------------------------------

  vim.keymap.set("n", "<leader>tn", ":w <bar> :TestNearest<CR>", { silent = true })
  vim.keymap.set("n", "<leader>tt", ":w <bar> :TestFile<CR>", { silent = true })
  vim.keymap.set("n", "<leader>ta", ":w <bar> :TestSuite<CR>", { silent = true })
  vim.keymap.set("n", "<leader>tl", ":w <bar> :TestLast<CR>", { silent = true })

  -- The built-in mapping for exiting terminal insert mode is difficult to type
  vim.keymap.set("t", "<C-o>", "<C-\\><C-n>")

  vim.g["test#strategy"] = "neovim"
  vim.g["test#filename_modifier"] = ":p" -- Required for testing Elixir umbrellas

  -----------------------------------------------------------------------------
  -- Treesitter Grammar
  -----------------------------------------------------------------------------

  require("nvim-treesitter.configs").setup({
    ensure_installed = {"elixir", "heex", "eex"}, -- only install parsers for elixir and heex
    sync_install = false,
    ignore_install = {},
    highlight = {
      enable = true
    },
    indent = {
      enable = true
    }
  })

  -----------------------------------------------------------------------------
  -- Completion
  -----------------------------------------------------------------------------

  local cmp = require("cmp")

  cmp.setup({
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" }
    }, {
      { name = "buffer" }
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -----------------------------------------------------------------------------
  -- LSP
  -----------------------------------------------------------------------------

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

      local opts = { buffer = ev.buf }

      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

      vim.keymap.set("n", "<leader>af", function() vim.lsp.buf.format { async = true } end, opts)

      vim.keymap.set("n", "<leader>ce", vim.diagnostic.open_float)
      vim.keymap.set("n", "<leader>cq", vim.diagnostic.setloclist)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
    end
  })

  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  require("lspconfig").elixirls.setup {
    cmd = { "/Users/parker/Work/Code/elixir-ls/rel/language_server.sh" },
    capabilities = capabilities
  }

  require'lspconfig'.rome.setup {
    capabilities = capabilities
  }

  -----------------------------------------------------------------------------
  -- Autocomplete
  -----------------------------------------------------------------------------

  vim.cmd([[
    function! InsertTabWrapper()
      let col = col('.') - 1
      if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
      else
        return "\<c-p>"
      endif
    endfunction
    inoremap <tab> <c-r>=InsertTabWrapper()<cr>
    inoremap <s-tab> <c-n>
  ]])

  -----------------------------------------------------------------------------
  -- Projectionist
  -----------------------------------------------------------------------------

  vim.cmd([[
    let g:projectionist_heuristics = {}

    let g:projectionist_heuristics['mix.exs'] = {
      \ 'apps/*/mix.exs': { 'type': 'app' },
      \ 'lib/*.ex': {
      \   'type': 'lib',
      \   'alternate': 'test/{}_test.exs',
      \   'template': ['defmodule {camelcase|capitalize|dot} do', 'end'],
      \ },
      \ 'test/*_test.exs': {
      \   'type': 'test',
      \   'alternate': 'lib/{}.ex',
      \   'template': ['defmodule {camelcase|capitalize|dot}Test do', '  use ExUnit.Case', '', '  alias {camelcase|capitalize|dot}, as: Subject', '', '  doctest Subject', 'end'],
      \ },
      \ 'mix.exs': { 'type': 'mix' },
      \ 'config/*.exs': { 'type': 'config' },
      \ '*.ex': {
      \   'makery': {
      \     'lint': { 'compiler': 'credo' },
      \     'test': { 'compiler': 'exunit' },
      \     'build': { 'compiler': 'mix' }
      \   }
      \ },
      \ '*.exs': {
      \   'makery': {
      \     'lint': { 'compiler': 'credo' },
      \     'test': { 'compiler': 'exunit' },
      \     'build': { 'compiler': 'mix' }
      \   }
      \ }
      \ }

    func! s:options() abort
      if &ft !=# '' | return | endif

      for [_, value] in projectionist#query('filetype')
        exec 'setf '.l:value
        return
      endfor
    endfunc

    augroup projectionist_ft
      au!
      au BufEnter * call <sid>options()
    augroup END
  ]])
end)
