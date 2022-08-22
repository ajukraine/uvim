local o = {
  encoding = 'utf-8',
  hidden = true,
}

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
o.showmode = false

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
o.mousemodel = 'extend'
o.ttymouse = 'xterm2' -- Not supported in Neovim

-- Enable backspace in Insert mode
o.backspace = '2'
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
o.signcolumn = 'yes'
o.number = true
o.relativenumber = true
o.cursorline = false

-- Set cursor shape depending on mode
-- (see more https://nickjanetakis.com/blog/change-your-vim-cursor-from-a-block-to-line-in-normal-and-insert-mode)
o.t_SI = [[[6 q]]
o.t_EI = [[[2 q]]

-- Set separator for vertical split (there is space in the end after \)
-- Vertical bar is a multi-bytes symbol https://unix.stackexchange.com/q/549008
o.fillchars=[[vert:┃,fold:-,eob:~]]

-- Display completion menu for command line
o.wildmenu = true

-- Transparency of completion menu
o.pumblend = 10

-- Speed up slow switch/escape from 'insert' to 'normal' mode
-- see more https://vi.stackexchange.com/a/18472
o.esckeys = false -- Not supported in Neovim

-- Speed up update timer for plugins like GitGutter, which depends on the for its updates
o.updatetime = 100

function from_opts(opts)
  o.termguicolors = opts.has_guicolors

  if opts.has_guicolors then
    -- Vim doesn't support explicitly "true color" in non "xterm-" terminals (see ':h xterm-true-color)
    -- For example, Alacritty
    -- https://github.com/alacritty/alacritty/issues/109#issuecomment-440353106
    o.t_8f=[[[38;2;%lu;%lu;%lum]]
    o.t_8b=[[[48;2;%lu;%lu;%lum]]
  end

  return o
end

return {
  get = from_opts
}
