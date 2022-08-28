if vim.b.did_kitty_autoreload then return -1 end
if vim.fn.executable('killall') ~= 1 then return -1 end

vim.api.nvim_create_autocmd('BufWritePost', {
  buffer = vim.api.nvim_get_current_buf(),
  command = 'silent !killall -SIGUSR1 kitty',
})

vim.b.did_kitty_autoreload = true
