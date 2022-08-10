local M = {}

M.get_config = function(opts)

  -- function that extends array 'base' with another array 'new'
  local function extend(base, new)
    for i, v in ipairs(new) do
      table.insert(base, v)
    end
    return base
  end

  local hooks = {
    ['PostPlugins'] = {}
  }

  local plugins = {
    { 'dstein64/vim-startuptime', on = 'StartupTime' },

    'ryanoasis/vim-devicons',
    'mhinz/vim-startify',

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

    'morhetz/gruvbox',
    -- 'lifepillar/vim-gruvbox8',

    'lambdalisue/battery.vim',
    'itchyny/lightline.vim',
    'airblade/vim-gitgutter',

    'junegunn/vim-easy-align',
    'tpope/vim-commentary',
    'tpope/vim-unimpaired',

    'kassio/neoterm',
    'diepm/vim-rest-console',

    'dense-analysis/ale',
    'editorconfig/editorconfig-vim',
  }

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
    })

    table.insert(hooks['PostPlugins'], function ()
      require("filetype").setup {
        overrides = {
          literal = {
            ["kitty.conf"] = "kitty",
            ["vimrc"]      = "vim",
          }
        }
      }
      require("zen-mode").setup {
        window = { height = 0.7 },
        plugins = {
          kitty = { enabled = true, font = "+4" },
        }
      }
      require("catppuccin").setup {
        transparent_background = true,
        dim_inactive = {
          enabled = true,
          percentage = 0.01,
        }
      }
      require("colorizer").setup { }
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "lua", "vim" },
        sync_install = false,
        highlight = { enable = true },
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              -- ["ac"] = "@class.outer",
              -- ["ic"] = "@class.inner",
            },
            -- You can choose the select mode (default is charwise 'v')
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V', -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
          },
        },
      }
    end)
  end

  if opts.is_vim then
   extend(plugins, {
     { 'sillybun/vim-repl', ['for'] = { 'python', 'typescript', 'cs' } },
     'prabirshrestha/vim-lsp',
     'mattn/vim-lsp-settings',
     'rhysd/vim-lsp-ale',
   })
  end

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

  if opts.has_guicolors then
    o.termguicolors = true

    -- Vim doesn't support explicitly "true color" in non "xterm-" terminals (see ':h xterm-true-color)
    -- For example, Alacritty
    -- https://github.com/alacritty/alacritty/issues/109#issuecomment-440353106
    o.t_8f=[[[38;2;%lu;%lu;%lum]]
    o.t_8b=[[[48;2;%lu;%lu;%lum]]
  end

  local custom_options = {
    colorscheme = 'catppuccin',
    transparent_background = false,
    -- colorscheme = 'gruvbox',
    -- colorscheme = 'tokyonight',
  }

  local globals = {
    ['battery#component_format'] = '%s %v%%',
    ['lightline#bufferline#enable_devicons'] = 1,
    lightline = {
      colorscheme = custom_options.colorscheme,
      active= {
        right= {{'battery'}, {'clock'}, {'fileformat', 'fileencoding', 'filetype'}}
      },
      component = {
        clock = '%{strftime("%b %d, %H:%M")}',
        filetype = '%{WebDevIconsGetFileTypeSymbol() . " (" . &filetype})'
      },
      component_function = {
        battery = 'battery#component',
      }
    },
    gruvbox_bold = 0,
    gruvbox_italic = 1,
    gruvbox_italicize_comments = 1,
    mapleader = ' ',
    startify_disable_at_vimenter = 1, -- Startify too slow at start
    python_recommended_style = 0, -- Built-in Python configuration
    sendtorepl_invoke_key = '<leader>r',
    repl_program = {
      typescript = 'npx ts-node',
      cs = 'dotnet repl',
    },

    neoterm_default_mod = 'belowright',
    neoterm_size = 16,
    neoterm_autoscroll = 1,

    mkdp_browser = 'min',

    lsp_document_code_action_signs_delay = 0,

    gitgutter_override_sign_column_highlight = 1,

    vrc_set_default_mapping = 0,

    tokyonight_style = 'storm',
    tokyonight_transparent = false,

    catppuccin_flavour = 'mocha',

    vim_markdown_folding_disabled = 1,

    -- Some weird optimization to avoid startup time of built-in ruby syntax plugin
    -- See more at: https://github.com/vim-ruby/vim-ruby/issues/248
    ruby_path = '/usr/bin/ruby',

    ale_virtualtext_cursor = 1,
    ale_virtualtext_prefix = '   ',
  }

  local mappings = {
    nnoremap = {
      ['<leader>w'] = '<cmd>w<CR>',
      ['<leader>q'] = '<cmd>q<CR>',
      ['<leader>e'] = '<cmd>Lexplore<CR>',
      ['<Tab>']     = '<cmd>bprev<CR>',
      [';']         = ':',
      ['ga']        = '<Plug>(EasyAlign)',
      ['\\\\']      = '<cmd>nohlsearch<CR>',

      ['<leader>i']  = '<plug>(lsp-implementation)',
      ['<leader>r']  = '<plug>(lsp-rename)',
      ['<leader>a']  = '<plug>(lsp-code-action)',
      ['<leader>u']  = '<plug>(lsp-references)',
      ['<leader>pi'] = '<plug>(lsp-peek-implementation)',
      ['<leader>s']  = '<plug>(lsp-signature-help)',

      ['<leader>j'] = '<cmd>call VrcQuery()<CR>',
    },

    xnoremap = {
      ['ga'] = '<Plug>(EasyAlign)'
    }
  }

  if opts.is_nvim then
    mappings.nnoremap[globals.sendtorepl_invoke_key] = '<cmd>TREPLSendLine<cr>j'
  end

  return {
    plugins = plugins,
    options = o,
    custom_options = custom_options,
    mappings = mappings,
    globals = globals,
    hooks = hooks,
  }

end

return M
