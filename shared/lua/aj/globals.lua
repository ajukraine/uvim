local function from_opts(opts)
  local colors_name = opts.is_nvim and 'catppuccin' or 'gruvbox8'

  local globals = {
    transparent_background = false,
    colors_name = colors_name,
    ['battery#component_format'] = '%s %v%%',
    ['lightline#bufferline#enable_devicons'] = 1, -- TODO: we don't do that
    lightline = {
      colorscheme = colors_name,
      active = {
        right = {--[[ {'battery'}, {'clock'}, ]] {'tablemode'}, {'fileformat', 'fileencoding', 'filetype'}}
      },
      component = {
        clock = '%{strftime("%b %d, %H:%M")}',
        filetype = '%{WebDevIconsGetFileTypeSymbol() . " (" . &filetype})',
        tablemode = '%{tablemode#IsActive() == 1 ? "TableMode" : ""}',
      },
      component_function = {
        battery = 'battery#component',
      }
    },
    gruvbox_transp_bg = 1,
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

  return globals
end

return {
  get = from_opts
}
