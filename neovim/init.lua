vim.o.compatible = false

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "init.lua",
	command = "source $MYVIMRC",
	group = vim.api.nvim_create_augroup("config_reload", { clear = true })
})

package.loaded['aj.config'] = nil
local config = require('aj.config').get_config { is_nvim = true, is_vim = false }

for name, value in pairs(config.options) do
	vim.o[name] = value
end
