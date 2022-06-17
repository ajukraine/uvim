local M = {}

M.plugins = {
  { 'dstein64/vim-startuptime', on = 'StartupTime' },

  'ryanoasis/vim-devicons',
  'mhinz/vim-startify',

  'fladson/vim-kitty',
  'godlygeek/tabular',
  'preservim/vim-markdown',
  {
    'iamcco/markdown-preview.nvim',
    ['for'] = 'markdown',

    -- Currently can't pass Lua function as argument to Vim9 'world'
    -- Due to https://github.com/vim/vim/issues/10587
    -- So instead use Vim command as string
    ['do'] = ':call mkdp#util#install()',
  },

  'lambdalisue/battery.vim',
  'itchyny/lightline.vim',

  'morhetz/gruvbox',

  'junegunn/vim-easy-align',
  'tpope/vim-commentary',
  'tpope/vim-unimpaired',
}

M.options = {
  encoding = 'utf-8',
  hidden = true,
}

local o = M.options

-- Always display status line
o.laststatus = 2

-- Use dark theme if possible
o.background = 'dark'

-- Avoid configuring Vim with special section on start and end of the opened file
o.modelines = 0

-- Enable faster rendering (fount in https://gist.github.com/simonista/8703722)
o.ttyfast = true

-- Disable annoying bell sounds
o.belloff = 'all'

-- Set terminal title to Vim controlled
o.title = true

-- Prefer split windows to the right of current one
o.splitright = true

-- Don't show current mode in the command line
-- Instead rely on statusline built-in or installed plugin
o.noshowmode = true

-- Use system clipboard by default
o.clipboard = 'unnamed'

-- Incrementally search while typing
o.incsearch = true
-- Use smart case for searching
o.ignorecase = true
o.smartcase = true
-- Highlight searches
o.hlsearch = true

-- Enable mouse
o.mouse = 'a'
o.ttymouse = 'xterm2'

-- Enable backspace in Insert mode
o.backspace = 2
-- Enable left/right arrows to move to prev/next lines in Normal, Visual, Insert and Replace modes
o.whichwrap = '<,>,[,]'

-- Use spaces instead of tabs, and set them to 2
o.expandtab = true
o.shiftwidth = 2
o.softtabstop = 2
o.tabstop = 2

-- Always show some lines below and above the cursor when scrolling
o.scrolloff = 5

-- Show vertical marking line, corresponding to 'textwidth'
o.textwidth = 100
o.colorcolumn = '+1'

-- Show relative line numbers, special signs (like git signs) and cursorline
o.signcolumn = 'number'
o.number = true
o.relativenumber = true
o.cursorline = true

-- Set cursor shape depending on mode
-- (see more https://nickjanetakis.com/blog/change-your-vim-cursor-from-a-block-to-line-in-normal-and-insert-mode)
o.t_SI = [[[6\ q]]
o.t_EI = [[[2\ q]]

-- Set separator for vertical split (there is space in the end after \)
o.fillchars='vert:\\ ,fold:-,eob:~'

-- Display completion menu for command line
o.wildmenu = true

-- Speed up slow switch/escape from 'insert' to 'normal' mode
-- see more https://vi.stackexchange.com/a/18472
o.noesckeys = true

M.custom_options = {
  transparent_background = true,
  colorscheme = 'gruvbox'
}

M.globals = {
  ['battery#component_format'] = '%s %v%%',
  ['lightline#bufferline#enable_devicons'] = 1,
  lightline = {
    colorscheme = M.custom_options.colorscheme,
    active= {
      right= {{'battery'}, {'clock'}, {'fileformat', 'fileencoding', 'filetype'}}
    },
    component= {
      clock= '%{strftime("%b %d, %H:%M")}'
    },
    component_function = {
      battery = 'battery#component'
    }
  },
  gruvbox_bold = 0,
  mapleader = ' '
}

M.mappings = {
  nnoremap = {
    ['<leader>w'] = '<cmd>w<CR>',
    ['<leader>q'] = '<cmd>q<CR>',
    ['<leader>e'] = '<cmd>Lexplore<CR>',
    ['<Tab>']     = '<cmd>bprev<CR>',
    [';']         = ':',
    ['ga']        = '<Plug>(EasyAlign)'
  },
  xnoremap = {
    ['ga'] = '<Plug>(EasyAlign)'
  }
}

return M
