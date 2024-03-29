local hooks = {
  ['PostPlugins'] = {}
}

local function from_opts(opts)
  if not opts.is_nvim then return hooks end

  table.insert(hooks['PostPlugins'], function ()
    require("filetype").setup {
      overrides = {
        literal = {
          ["vimrc"] = "vim",
        },
        extensions = {
          ["fish"] = "fish",
          ["fs"]   = "fsharp",
        },
        endswith = {
          ["/kitty.*%.conf"] = "kitty",
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

    if opts.has_guicolors then
      require("catppuccin").setup {
        transparent_background = true,
        dim_inactive = {
          enabled = false,
          percentage = 0.01,
        }
      }
      require("colorizer").setup() 
    end

    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.awk = {
      install_info = {
        url = "~/dev/tree-sitter-awk", -- local path or git repo
        files = {"src/parser.c"},
        -- optional entries:
        -- branch = "main", -- default branch in case of git repo if different from master
        generate_requires_npm = false, -- if stand-alone parser without npm dependencies
        requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
      },
      filetype = "awk", -- if filetype does not match the parser name
    }

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
      endwise = { enable = true },
    }
    require('Comment').setup()

    local telescope = require('telescope')
    telescope.setup()
    telescope.load_extension('fzf')

    require('noice').setup {
      views = {
        cmdline_popup = {
          position = {
            row = 5,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
          border = {
            text = { top = " Command " },
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 8,
            col = "50%",
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
          },
        },
      },
    }
  end)

  return hooks
end


return {
  get = from_opts
}
