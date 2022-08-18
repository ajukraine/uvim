-- function that extends array 'base' with another array 'new'
local function extend(base, new)
  for i, v in ipairs(new) do
    table.insert(base, v)
  end
  return base
end

local plugins = {
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

  -- 'morhetz/gruvbox',
  -- 'lifepillar/vim-gruvbox8',

  -- 'lambdalisue/battery.vim',
  'itchyny/lightline.vim',
  'airblade/vim-gitgutter',

  { 'junegunn/vim-easy-align', on = '<Plug>(EasyAlign)' },
  'tpope/vim-unimpaired',

  'kassio/neoterm',
  'diepm/vim-rest-console',

  'dense-analysis/ale',
  'editorconfig/editorconfig-vim',
}

local function from_opts(opts)
  if opts.is_nvim then
    extend(plugins, {
      'nathom/filetype.nvim',
      'github/copilot.vim',
      'folke/zen-mode.nvim',

      { 'folke/tokyonight.nvim', ['branch'] = 'main' },
      'catppuccin/nvim',
      'norcalli/nvim-colorizer.lua',

      { 'nvim-treesitter/nvim-treesitter', ['do'] = ':TSUpdate' },
      'nvim-treesitter/nvim-treesitter-textobjects',

      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope.nvim', ['branch'] = '0.1.x' },

      'numToStr/Comment.nvim',
    })
  end

  if opts.is_vim then
    extend(plugins, {
      { 'sillybun/vim-repl', ['for'] = { 'python', 'typescript', 'cs' } },
      'prabirshrestha/vim-lsp',
      'mattn/vim-lsp-settings',
      'rhysd/vim-lsp-ale',
      'tpope/vim-commentary',
      'lifepillar/vim-gruvbox8',
    })
  end

  return plugins
end

return {
  get = from_opts
}
