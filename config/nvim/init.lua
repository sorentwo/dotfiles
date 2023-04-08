return require('packer').startup(function(use)
  use "wbthomason/packer.nvim"

  -- Syntax & Colors
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use "sainnhe/everforest"

  -- Navigation
  use "nvim-lua/plenary.nvim"
  use "nvim-lualine/lualine.nvim"
  use "nvim-telescope/telescope.nvim"
  use "nvim-tree/nvim-tree.lua"
  use "nvim-tree/nvim-web-devicons"

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

  vim.keymap.set("n", "<leader>ed", ":tabe TODO<CR>")
  -- vim.keymap.set("n", "<leader>md", ":!open -a /Applications/Marked\ 2.app %<CR>")

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
  vim.g.everforest_background = "hard"
  vim.g.everforest_better_performance = 1
  vim.cmd.colorscheme("everforest")

  require("lualine").setup({
    options = {
      theme = "everforest"
    }
  })

  -----------------------------------------------------------------------------
  -- Search
  -----------------------------------------------------------------------------

  local builtin = require("telescope.builtin")
  vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
  vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
  vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
  vim.keymap.set("n", "<leader>fc", builtin.git_commits, {})

  -----------------------------------------------------------------------------
  -- File Tree
  -----------------------------------------------------------------------------

  -- Disable netrw for nvim-tree
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
      side = "right"
    }
  })

  local ntree = require("nvim-tree.api")

  vim.keymap.set("n", "<leader>fd", ntree.tree.toggle, {})

  -----------------------------------------------------------------------------
  -- Testing
  -----------------------------------------------------------------------------

  vim.keymap.set("n", "<leader>tn", ":TestNearest<CR>", { silent = true })
  vim.keymap.set("n", "<leader>tt", ":TestFile<CR>", { silent = true })
  vim.keymap.set("n", "<leader>ta", ":TestSuite<CR>", { silent = true })
  vim.keymap.set("n", "<leader>tl", ":TestLast<CR>", { silent = true })

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
      enable = true,
      disable = {},
    },
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

  require("lspconfig").elixirls.setup {
    cmd = { "/Users/parker/Work/Code/elixir-ls/rel/language_server.sh" }
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
