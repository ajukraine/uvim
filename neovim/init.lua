local config_file = vim.fn.expand('$MYVIMRC')
local config_folder = vim.fn.fnamemodify(config_file, ':h')
local plugins_folder = config_folder .. '/data/plugged'

local function bootstrap_vimplug()
  local vimplug_folder = plugins_folder .. '/vim-plug'

  if vim.fn.isdirectory(vim.fn.expand(vimplug_folder)) == 0 then
    local vimplug_repo_url = 'https://github.com/junegunn/vim-plug'

    vim.fn.execute('!git clone ' .. vimplug_repo_url .. ' ' .. vimplug_folder)
  end

  -- Autoload 'plug.vim' from cloned repo
  vim.api.nvim_create_autocmd('FuncUndefined', {
    pattern = 'plug#*',
    command = 'source ' .. vimplug_folder .. '/plug.vim',
    group = vim.api.nvim_create_augroup("autoload_vimplug", { clear = true })
  })
end

local function configure_plugins(plugins)
  local Plug = vim.fn['plug#']

  vim.call('plug#begin', plugins_folder)

  for i, plugin in ipairs(plugins) do
    local opts = {}
    if type(plugin) == type({}) then
      opts = plugin
      plugin = plugin[1]
      table.remove(opts, 1)
    end
    if vim.tbl_isempty(opts) then
      Plug(plugin)
    else
      Plug(plugin, opts)
    end
  end

  vim.call('plug#end')
end

local function configure_options(options)
  for name, value in pairs(options) do
    if vim.fn.exists('+' .. name) == 0 then
      -- TODO: log unsupported options
      -- print('Unsupported option: ' .. name)
    else
      vim.o[name] = value
    end
  end
end

local function configure_globals(globals)
  for name, value in pairs(globals) do
    vim.g[name] = value
  end
end

local function trigger_hook(hooks, hook)
  for i, action in ipairs(hooks[hook]) do
    action()
  end
end

local function configure_mappings(mappings)
  local mappers = {
    nnoremap = { mode = 'n', opts = { noremap = true } },
    xnoremap = { mode = 'x', opts = { noremap = true } },
  }

  for mapper, bindings in pairs(mappings) do
    local args = mappers[mapper]

    for key, action in pairs(bindings) do
      vim.keymap.set(args.mode, key, action, args.opts)
    end
  end
end

local function configure_custom_options(custom_options)
  if vim.g.transparent_background then
    vim.api.nvim_create_autocmd("Colorscheme", {
      pattern = "*",
      callback = function () vim.cmd.highlight({ "Normal", "guibg=NONE", "ctermbg=NONE" }) end,
      group = vim.api.nvim_create_augroup("colorscheme_transparent_bg", { clear = true }),
    })
  end

  if vim.g.colors_name then
    vim.cmd.colorscheme(vim.g.colors_name)
  end
end

local function configure_commands(commands)
  for name, cmd in pairs(commands) do
    vim.api.nvim_create_user_command(name, cmd, {})
  end
end

local function config_refresh()
  package.loaded['aj.config'] = nil
end

local function lightline_reload()
  vim.call('lightline#init')
  vim.call('lightline#colorscheme')
  vim.call('lightline#update')
end

vim.api.nvim_create_user_command("LightlineReload", lightline_reload, {})

local augroup_config = vim.api.nvim_create_augroup("config_reload", { clear = true })

local function create_config_autocmd(event, handler, pattern)
  local opts = { pattern = config_file, nested = true, group = augroup_config }
  opts.pattern = pattern or opts.pattern

  if type(handler) == type('') then
    opts.command = handler
  else
    opts.callback = handler
  end
  vim.api.nvim_create_autocmd(event, opts)
end

local uvim_folder = vim.fn.fnamemodify(config_folder, ":h")

create_config_autocmd("BufWritePost", "source $MYVIMRC", uvim_folder .. '/shared/*.lua')
create_config_autocmd("BufWritePost", "source $MYVIMRC")
create_config_autocmd("SourcePre", config_refresh)
create_config_autocmd("SourcePost", "LightlineReload")

local opts = {
  is_nvim = true,
  is_vim = false,
  has_guicolors = vim.fn.has('termguicolors') == 1 and vim.fn.getenv('COLORTERM') == 'truecolor'
}

local config = require('aj.config').get_config(opts)

bootstrap_vimplug()
configure_options(config.options)
configure_globals(config.globals)
configure_plugins(config.plugins)
require('impatient')
trigger_hook(config.hooks, 'PostPlugins')
configure_mappings(config.mappings)
configure_custom_options(config.custom_options)
configure_commands(config.commands)
