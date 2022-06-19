vim.o.compatible = false

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "init.lua",
	command = "source $MYVIMRC",
	group = vim.api.nvim_create_augroup("config_reload", { clear = true })
})

package.loaded['aj.config'] = nil
local opts = {
  is_nvim = true,
  is_vim = false,
  has_guicolors = vim.fn.has('termguicolors') == 1
}
local config = require('aj.config').get_config(opts)

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
  xnoremap = { mode = 'n', opts = { noremap = true } },
}

for mapper, mappings in pairs(config.mappings) do
  local args = mappers[mapper]

  for key, action in pairs(mappings) do
    vim.keymap.set(args.mode, key, action, args.opts)
  end
end
