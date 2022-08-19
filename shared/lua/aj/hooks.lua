local hooks = {
  ['PostPlugins'] = {}
}

local function from_opts(opts)
  if not opts.is_nvim then return hooks end

  table.insert(hooks['PostPlugins'], function ()
    require("filetype").setup {
      overrides = {
        literal = {
          ["kitty.conf"] = "kitty",
          ["vimrc"]      = "vim",
        }
      }
    }

    -- TODO: make it possible to setup plugin on demand, when it's loaded
    require("zen-mode").setup {
      window = { height = 0.7 },
      plugins = {
        kitty = { enabled = true, font = "+4" },
      }
    }
    require("catppuccin").setup {
      transparent_background = true,
      dim_inactive = {
        enabled = false,
        percentage = 0.01,
      }
    }
    require("colorizer").setup { }
    require("nvim-treesitter.configs").setup {
      ensure_installed = { "lua", "vim" },
      sync_install = false,
      highlight = { enable = true },
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            -- ["ac"] = "@class.outer",
            -- ["ic"] = "@class.inner",
          },
          -- You can choose the select mode (default is charwise 'v')
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
        },
      },
      textsubjects = {
        enable = true,
        prev_selection = ',', -- (Optional) keymap to select the previous selection
        keymaps = {
          ['<cr>'] = 'textsubjects-smart',
          [';'] = 'textsubjects-container-outer',
          ['i;'] = 'textsubjects-container-inner',
        },
      },
    }
    require('Comment').setup()
  end)

  return hooks
end

return {
  get = from_opts
}
