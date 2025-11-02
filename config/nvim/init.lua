return require("packer").startup(function(use)
  use "wbthomason/packer.nvim"

  -- Syntax & Colors
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use { "folke/tokyonight.nvim", as = "tokyotonight" }

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

  -- Utils
  use "godlygeek/tabular"
  use "janko-m/vim-test"
  use 'nvim-pack/nvim-spectre'
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
  -- Filetype Overrides
  -----------------------------------------------------------------------------

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
      vim.opt.shiftwidth = 2
      vim.opt.tabstop = 2
      vim.opt.softtabstop = 2
    end,
  })

  -----------------------------------------------------------------------------
  -- Colorscheme
  -----------------------------------------------------------------------------

  vim.o.termguicolors = true

  require("tokyonight").setup({
    styles = {
      comments = { italic = true },
      keywords = { italic = false },
    }
  })

  vim.cmd.colorscheme("tokyonight")

  -- Override module and atom highlights for Elixir
  vim.cmd.highlight("link @module.elixir @lsp.type.struct")
  vim.cmd.highlight("link @string.special.symbol @string")

  require("lualine").setup({
    options = {
      theme = "auto"
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {'filetype'},
      lualine_y = {},
      lualine_z = {'location'}
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
      side = "left"
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
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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
      vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "]g", vim.diagnostic.goto_next)

      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

      vim.keymap.set("n", "<leader>af", function() vim.lsp.buf.format { async = true } end, opts)

      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>ce", vim.diagnostic.open_float)
      vim.keymap.set("n", "<leader>cq", vim.diagnostic.setloclist)
    end
  })

  vim.lsp.config("lexical", {
    cmd = { "/Users/parker/Work/Code/lexical/_build/dev/package/lexical/bin/start_lexical.sh" },
    root_markers = { "mix.exs", ".git" },
    filetypes = { "elixir", "eelixir", "heex" },
  })

  vim.lsp.enable("lexical")

  vim.lsp.config("ruff", {
    cmd = { "ruff", "server" },
    root_markers = { "pyproject.toml" },
    filetypes = { "python" }
  })

  vim.lsp.enable("ruff")

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
      \   'template': ['defmodule {camelcase|capitalize|dot}Test do', '  use ExUnit.Case, async: true', '', '  alias {camelcase|capitalize|dot}', '', 'end'],
      \ },
      \ 'mix.exs': { 'type': 'mix' },
      \ 'config/*.exs': { 'type': 'config' }
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

  -----------------------------------------------------------------------------
  -- CopyToRTF
  -----------------------------------------------------------------------------

  vim.api.nvim_create_user_command('ToRTF', function()
    vim.cmd('TOhtml tmp.html | w!')
    vim.cmd([[exec "!textutil -convert rtf -stdout -font TX-02 -fontsize 32 tmp.html | pbcopy"]])
    vim.cmd('Remove')
    vim.cmd('bd')
  end, {})
end)
