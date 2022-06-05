vim9script

import './myplug.vim'

# Don't try to be Vi compatible
# Enables Vim features, which are not compatible with Vi
set nocompatible

# Setup autoreload of config when it's saved
autocmd! BufWritePost $MYVIMRC ++nested source <afile>
autocmd! SourcePost $MYVIMRC ++nested call LightlineReload()

var vimrc_folder = fnamemodify(resolve(expand('<sfile>:p')), ':h')

myplug.Begin(vimrc_folder)

Plug 'dstein64/vim-startuptime'

# Fancy start screen
Plug 'mhinz/vim-startify'

# Show battery information on statusline/tabline
Plug 'lambdalisue/battery.vim'

# Kitty config syntax highlighting
Plug 'fladson/vim-kitty'

### Color schemes
# Plug 'embark-theme/vim', { 'as': 'embark' }
# Plug 'artanikin/vim-synthwave84'
# Plug 'ntk148v/vim-horizon'
# Plug 'ajukraine/vim-monokai-bold'
Plug 'morhetz/gruvbox'
# Plug 'shinchu/lightline-gruvbox.vim'

### Editing assistance
# Plug 'ervandew/supertab'
Plug 'tpope/vim-commentary'
# Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-unimpaired' #Magical key bindings like '[p [<Space>'
# Plug 'prettier/vim-prettier', {
#       \ 'do': 'npm install',
#       \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
# Plug 'junegunn/goyo.vim'
# Plug 'junegunn/limelight.vim'

### Syntax/Language support
# Plug 'pangloss/vim-javascript'
# Plug 'maxmellon/vim-jsx-pretty'
# Plug 'digitaltoad/vim-pug'
# Plug 'othree/html5.vim'
# Plug 'dNitro/vim-pug-complete', { 'for': ['jade', 'pug'] }
# Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
# Plug 'cespare/vim-toml', { 'branch': 'main' }
# Plug 'sheerun/vim-polyglot'
# Plug 'othree/yajs.vim'
# Plug 'ionide/Ionide-vim', { 'do':  'make fsautocomplete' }

### Layout/Appearance
Plug 'itchyny/lightline.vim'
# Plug 'itchyny/vim-gitbranch'
# Plug 'mengelbrecht/lightline-bufferline'
# Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
# Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

### Motion and navation
# Plug 'yuttie/comfortable-motion.vim'

### Experimenal stuff
# Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
# Plug 'roxma/vim-hug-neovim-rpc'
# Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
# Plug 'deoplete-plugins/deoplete-lsp'
# Plug 'neovim/nvim-lspconfig'

### Supporting tools
# Plug 'dstein64/vim-startuptime'

myplug.End()

## ACTUAL CONFIG START
set encoding=utf-8
set hidden

# lua require('myconfig')

# Detect support of 'true colors'
var has_guicolors = $COLORTERM == 'truecolor' && exists('+termguicolors') || has('gui_vimr') || exists('g:fvim_loaded')

# Use dark theme if possible
set background=dark

# Make background transparent after color scheme is changed
autocmd! Colorscheme * hi Normal guibg=NONE ctermbg=NONE

if has_guicolors
  set termguicolors
endif

# Avoid configuring Vim with special section on start and end of the opened file
set modelines=0

# Enable faster rendering (fount in https://gist.github.com/simonista/8703722)
set ttyfast

# Disable annoying bell sounds
set belloff=all

set title
set splitright
# set clipboard=unnamed

syntax on
filetype plugin indent on

# Always display status line
set laststatus=2

g:battery#component_format = '%s %v%%'

g:lightline = { }

var right_side = [['battery'], ['clock'], ['fileformat', 'fileencoding', 'filetype']]
g:lightline.active             = {'right': right_side }
g:lightline.component          = {
  'clock': '%{strftime("%b %d, %H:%M")}',
  }

#'gitbranch': 'gitbranch#name'
g:lightline.component_function = { 
  'battery': 'battery#component',
  }

# g:lightline.tabline            = { 'left': [['buffers']] }
# g:lightline.component_expand   = { 'buffers': 'lightline#bufferline#buffers' }
# g:lightline.component_type     = { 'buffers': 'tabsel' }
# g:lightline.subseparator       = { 'left': #\ue0b1#, 'right': #\ue0b3# }

if has_guicolors
  g:lightline.colorscheme = 'gruvbox'
endif

# g:lightline#bufferline#show_number = 1
g:lightline#bufferline#enable_devicons = 1

# Reloads lightline after changes to config
def LightlineReload()
  lightline#init()
  lightline#colorscheme()
  lightline#update()
enddef

# Don't show current mode in the command line
# Instead rely on statusline built-in or installed plugin
set noshowmode

# Fallback to built-in status line
# set statusline=%<%f\ %y%h%m%r%=%-14.(%l,%c%V%)\ %P

if has_guicolors
#   g:gruvbox_italicize_strings = 0
#   g:gruvbox_bold = 0

#   g:gruvbox_filetype_hi_groups = 1
#   g:gruvbox_plugin_hi_groups = 0

#   # Limelight can't automatically determine dim color when transparency is on
#   g:gruvbox_transp_bg = 1
#   g:limelight_conceal_ctermfg = 'DarkGrey'
#   g:limelight_conceal_guifg = 'DarkGray'

  colorscheme gruvbox
else
#   colorscheme monokai-bold
endif


# Exit Vim if NERDTree is the only window remaining in the only tab.
# autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

# set omnifunc=syntaxcomplete#Complete
# if has(#autocmd#) && exists(#+omnifunc#)
#   # provides completion based syntax keywords
#   autocmd Filetype *
#         \ if &omnifunc == ## |
#         \   setlocal omnifunc=syntaxcomplete#Complete |
#         \ endif
#   autocmd Filetype *
#         \ if &omnifunc != '' |
#         \   call SuperTabChain(&omnifunc, #<c-p>#) |
#         \ endif
# endif

# Incrementally search while typing
set incsearch
# Use smart case for searching
set ignorecase smartcase
# Highlight searches
set hlsearch

# Enable mouse
set mouse=a
set ttymouse=xterm2

# Enable backspace in Insert mode
set backspace=2
# Enable left/right arrows to move to prev/next lines in Normal, Visual, Insert and Replace modes
set whichwrap+=<,>,[,]

### Use spaces instead of tabs, and set them to 2
set expandtab
set shiftwidth=2
set softtabstop=2

# Always show some lines below and above the cursor when scrolling
set scrolloff=5

### Show vertical marking line, corresponding to 'textwidth'
set textwidth=100
set colorcolumn=+1

### Show relative line numbers, special signs (like git signs) and cursorline
set signcolumn=number
set number relativenumber
set cursorline

### Hide cursorline for inactive windows
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

# Set separator for vertical split (there is space in the end after \)
set fillchars+=vert:\ 

##-- FOLDING --
#set foldmethod      = syntax # syntax highlighting items specify folds
#set foldcolumn      = 1      # defines 1 col at window left, to indicate folding
#let javaScript_fold = 1 # activate folding by JS syntax
#set foldlevelstart  = 99 # start file with all folds opened

# Set cursor shape depending on mode
# (see more https://nickjanetakis.com/blog/change-your-vim-cursor-from-a-block-to-line-in-normal-and-insert-mode)
&t_SI = "\e[6 q"
&t_EI = "\e[2 q"

# autocmd! User GoyoEnter Limelight
# autocmd! User GoyoLeave Limelight!

# Display completion menu for command line
set wildmenu

# Speed up slow switch/escape to 'normal' mode (see more https://vi.stackexchange.com/a/18472)
set noesckeys

### Custom key bindings
g:mapleader = ' '
nnoremap <leader>w     <Cmd>w<CR>
nnoremap <leader>q     <Cmd>q<CR>
nnoremap <leader>e     <Cmd>Lexplore<CR>
nnoremap <Tab>         <cmd>bprev<cr>
nnoremap ; :
# nnoremap <leader>o     <Cmd>only<CR>
# nnoremap <leader>d     <Cmd>bp\|bd #<CR>
# nnoremap <expr>,       '<Cmd>b ' . v:count1 . '<CR>'
# nnoremap <leader><Tab> <Cmd>bprev<CR>
# noremap  <C-d>         <Cmd>NERDTreeToggleVCS<CR>
# inoremap <C-d>         <Cmd>NERDTreeToggleVCS<CR>
# nnoremap <leader>z     <Cmd>Goyo<CR>
# nnoremap <leader>r     <Cmd>w<CR><Cmd>so %<cr>

# Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
# # Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

# g:comfortable_motion_no_default_key_mappings = 1
# noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(20)<CR>
# noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-20)<CR>

# For GUI terminals
# set guifont=FiraCode\ Nerd\ Font:h16

# g:neovide_transparency=0.95
