vim.o.compatible = false

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "init.lua",
  nested = true,
  command = "source $MYVIMRC",
  group = vim.api.nvim_create_augroup("config_reload", { clear = true })
})

-- Setup bootstrap of vim-plug
local vimplug_install_path = vim.fn.stdpath('data') .. '/site/autoload/plug.vim'

if vim.fn.filereadable(vim.fn.expand(vimplug_install_path)) == 0 then
  local vimplug_github_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  vim.fn.execute('!curl -fLo ' .. vimplug_install_path .. ' --create-dirs ' .. vimplug_github_url)
end

package.loaded['aj.config'] = nil
local opts = {
  is_nvim = true,
  is_vim = false,
  has_guicolors = vim.fn.has('termguicolors') == 1
}
local config = require('aj.config').get_config(opts)

local Plug = vim.fn['plug#']

vim.call('plug#begin')

for i, plugin in ipairs(config.plugins) do
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

for name, value in pairs(config.options) do
  if vim.fn.exists('+' .. name) == 0 then
    -- TODO: log unsupported options
    -- print('Unsupported option: ' .. name)
  else
    vim.o[name] = value
  end
end

for name, value in pairs(config.globals) do
  vim.g[name] = value
end

local mappers = {
  nnoremap = { mode = 'n', opts = { noremap = true } },
  xnoremap = { mode = 'x', opts = { noremap = true } },
}

for mapper, mappings in pairs(config.mappings) do
  local args = mappers[mapper]

  for key, action in pairs(mappings) do
    vim.keymap.set(args.mode, key, action, args.opts)
  end
end

-- Make background transparent after color scheme is changed
if config.custom_options.transparent_background then
  vim.cmd [[autocmd! Colorscheme * hi Normal guibg=NONE ctermbg=NONE]]
end

if config.custom_options.colorscheme then
  vim.cmd([[colorscheme ]] .. config.custom_options.colorscheme)
end
