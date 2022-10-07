-- function that extends array 'base' with another array 'new'
local function extend(base, new)
  for i, v in ipairs(new) do
    table.insert(base, v)
  end
  return base
end

local function from_opts(opts)
  local plugins = {
    '~/dev/tree-sitter-awk/',

    'lewis6991/impatient.nvim',
    { 'dstein64/vim-startuptime', on = 'StartupTime' },

    'ryanoasis/vim-devicons',
    { 'mhinz/vim-startify', on = 'Startify' },

    { 'khaveesh/vim-fish-syntax',           ['for'] = 'fish' },
    { 'fladson/vim-kitty',                  ['for'] = { 'kitty', 'kitty-session' } },
    { 'godlygeek/tabular',                  ['for'] = 'markdown' },
    { 'preservim/vim-markdown',             ['for'] = 'markdown' },
    {
      'iamcco/markdown-preview.nvim',       ['for'] = 'markdown',

      -- Currently can't pass Lua function as argument to Vim9 'world'
      -- Due to https://github.com/vim/vim/issues/10587
      -- So instead use Vim command as string
      ['do'] = ':call mkdp#util#install()',
    },
    'dhruvasagar/vim-table-mode',

    -- 'lambdalisue/battery.vim',
    'itchyny/lightline.vim',
    'airblade/vim-gitgutter',

    { 'junegunn/vim-easy-align', on = '<Plug>(EasyAlign)' },
    'tpope/vim-unimpaired',

    'kassio/neoterm',
    'diepm/vim-rest-console',

    'dense-analysis/ale',
    'editorconfig/editorconfig-vim',

    'hashivim/vim-terraform',
    'OmniSharp/omnisharp-vim',
  }

  if opts.is_nvim then
    extend(plugins, {
      'nathom/filetype.nvim',
      'github/copilot.vim',
      'folke/zen-mode.nvim',

      { 'folke/tokyonight.nvim', ['branch'] = 'main' },

      { 'nvim-treesitter/nvim-treesitter', ['do'] = ':TSUpdate' },
      'nvim-treesitter/nvim-treesitter-textobjects',
      'RRethy/nvim-treesitter-textsubjects',
      'nvim-treesitter/playground',
      'RRethy/nvim-treesitter-endwise',

      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope.nvim', ['branch'] = '0.1.x' },
      { 'nvim-telescope/telescope-fzf-native.nvim', ['do'] = 'make'  },

      'numToStr/Comment.nvim',

      'adelarsq/neofsharp.vim',

      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
      "folke/noice.nvim",
    })
  end

  if opts.is_vim then
    extend(plugins, {
      { 'sillybun/vim-repl', ['for'] = { 'python', 'typescript', 'cs' } },
      'prabirshrestha/vim-lsp',
      'mattn/vim-lsp-settings',
      'rhysd/vim-lsp-ale',
      'tpope/vim-commentary',
    })
  end

  if (opts.has_guicolors and opts.is_nvim) then
    extend(plugins, {
      'catppuccin/nvim',
      'norcalli/nvim-colorizer.lua',
    })
  else
    extend(plugins, {
      'lifepillar/vim-gruvbox8',
    })
  end

  return plugins
end

return {
  get = from_opts
}
