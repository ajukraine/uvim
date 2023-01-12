if vim.g.did_amethyst_autoreload then return -1 end

print "Setting amethyst autoreload"
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = ".amethyst.yml",
  callback = function ()
    vim.schedule(function ()
      vim.fn.system {
        "osascript",
        '-e tell application "System Events" to keystroke "x" using {option down, shift down}',
      }
    end)
  end
})

vim.g.did_amethyst_autoreload = true
