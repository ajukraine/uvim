local config_file = vim.fn.expand('$MYVIMRC')
local config_folder = vim.fn.fnamemodify(config_file, ':h')
local plugins_folder = config_folder .. '/data/plugged'

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
  package.loaded['aj.lazy'] = nil -- temporary workaround
  package.loaded['aj.vimplug'] = nil -- temporary workaround
end

local function lightline_reload()
  vim.call('lightline#init')
  vim.call('lightline#colorscheme')
  vim.call('lightline#update')
end

vim.api.nvim_create_user_command("LightlineReload", lightline_reload, {})

local augroup_config = vim.api.nvim_create_augroup("config_reload", { clear = true })

local function create_config_autocmd(event, handler, pattern)
  local opts = {
    pattern = pattern or config_file,
    nested = true,
    group = augroup_config
  }

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
  has_guicolors = vim.fn.has('termguicolors') == 1 and vim.fn.getenv('COLORTERM') == 'truecolor',
  config_folder = config_folder,
}

local timings = {}
function add_timing(label, duration)
  table.insert(timings, label .. ' : ' .. (duration / 1000 / 1000) .. ' ms')
end
function print_timings()
  for i, msg in ipairs(timings) do
    -- print(msg)
  end
end

function t(label, fun)
  return function (...)
    local ts = vim.loop.hrtime()
    result = fun(...)
    add_timing('t ' .. label, vim.loop.hrtime() - ts)

    return result
  end
end

local config = require('aj.config').get_config(opts)
local use_lazy = true
local plugin_manager = use_lazy and require('aj.lazy') or require('aj.vimplug')

t('bootstrap', plugin_manager.bootstrap)(opts)
t('configure_options', configure_options)(config.options)
t('configure_globals', configure_globals)(config.globals)
t('configure_plugins', plugin_manager.configure_plugins)(config.plugins, opts)
-- require('impatient')
t('trigger_hook', trigger_hook)(config.hooks, 'PostPlugins')
t('configure_mappings', configure_mappings)(config.mappings)
t('configure_custom_options', configure_custom_options)(config.custom_options)
t('configure_commands', configure_commands)(config.commands)

print_timings()
