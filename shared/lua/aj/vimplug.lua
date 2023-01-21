local M = {}

function get_plugins_folder(opts)
  return opts.config_folder .. '/data/plugged'
end

function M.bootstrap(opts)
  local vimplug_folder = get_plugins_folder(opts) .. '/vim-plug'

  -- TODO: consider using `vim.loop.fs_stat(vimplug_folder)` instead
  if vim.fn.isdirectory(vim.fn.expand(vimplug_folder)) == 0 then
    vim.fn.system({ 'git', 'clone', 'https://github.com/junegunn/vim-plug', vimplug_folder })
  end

  -- Autoload 'plug.vim' from cloned repo
  vim.api.nvim_create_autocmd('FuncUndefined', {
    pattern = 'plug#*',
    command = 'source ' .. vimplug_folder .. '/plug.vim',
    group = vim.api.nvim_create_augroup("autoload_vimplug", { clear = true })
  })
end

function M.configure_plugins(plugins, opts)
  local Plug = vim.fn['plug#']

  vim.call('plug#begin', get_plugins_folder(opts))

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

  vim.call('plug#end')end
return M
