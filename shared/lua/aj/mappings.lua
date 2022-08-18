local mappings = {
  nnoremap = {
    ['<leader>w'] = '<cmd>w<CR>',
    ['<leader>q'] = '<cmd>q<CR>',
    ['<leader>e'] = '<cmd>Lexplore<CR>',
    ['<Tab>']     = '<cmd>bprev<CR>',
    [';']         = ':',
    ['ga']        = '<Plug>(EasyAlign)',
    ['\\\\']      = '<cmd>nohlsearch<CR>',

    ['<C-n>']      = '<cmd>enew<CR>',
    ['<C-x>']      = '<cmd>bwipeout<CR>',

    ['<leader>i']  = '<plug>(lsp-implementation)',
    ['<leader>r']  = '<plug>(lsp-rename)',
    ['<leader>a']  = '<plug>(lsp-code-action)',
    ['<leader>u']  = '<plug>(lsp-references)',
    ['<leader>pi'] = '<plug>(lsp-peek-implementation)',
    ['<leader>s']  = '<plug>(lsp-signature-help)',

    ['<leader>j'] = '<cmd>call VrcQuery()<CR>',

    ['<leader><leader>'] = '<cmd>Telescope<CR>',
    ['<leader><leader>f'] = '<cmd>Telescope find_files<CR>',
    ['<leader><leader>g'] = '<cmd>Telescope git_files<CR>',
    ['<leader><leader>l'] = '<cmd>Telescope live_grep<CR>',

    ['\\<BS>'] = '<cmd>StartupTime --tries 10<CR>',
    ['\\<CR>'] = '<cmd>so $MYVIMRC<CR>',
  },

  xnoremap = {
    ['ga'] = '<Plug>(EasyAlign)'
  }
}


-- TODO: do smth
-- if opts.is_nvim then
-- mappings.nnoremap[globals.sendtorepl_invoke_key] = '<cmd>TREPLSendLine<cr>j'
-- end

return {
  get = function (opts) return mappings end
}
