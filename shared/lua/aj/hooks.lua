local hooks = {
  ['PostPlugins'] = {}
}

local function from_opts(opts)
  if not opts.is_nvim then return hooks end

  table.insert(hooks['PostPlugins'], function ()
    pcall(require, 'impatient')

    -- require("filetype").setup {
    --   overrides = {
    --     literal = {
    --       ["vimrc"] = "vim",
    --     },
    --     extensions = {
    --       ["fish"] = "fish",
    --       ["fs"]   = "fsharp",
    --     },
    --     endswith = {
    --       ["/kitty.*%.conf"] = "kitty",
    --     }
    --   }
    -- }

    -- TODO: make it possible to setup plugin on demand, when it's loaded
    -- require("zen-mode").setup {
    --   window = { height = 0.7 },
    --   plugins = {
    --     kitty = { enabled = true, font = "+4" },
    --   }
    -- }

    if opts.has_guicolors then
      require("catppuccin").setup {
        transparent_background = true,
        dim_inactive = {
          enabled = false,
          percentage = 0.01,
        },
        custom_highlights = function (colors)
          return {
            -- Avoid nvim-notify's transparent background warning at startup
            -- https://github.com/rcarriga/nvim-notify/issues/159
            NotifyBackground = { bg = colors.base }
          }
        end
      }
      -- require("colorizer").setup() 
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
        prev_selection = '<BS>', -- (Optional) keymap to select the previous selection
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
    telescope.setup {
      extensions = {
        file_browser = {
          hijack_netrw = true,
          grouped      = true, -- Group folders and files
          hidden       = true,
          initial_mode = 'normal', -- I always switch to normal mode
          sorting_strategy = 'ascending', -- More usual sorting
          layout_config = {
            prompt_position = 'top', -- More usual location
            anchor = 'N', -- Stick to top edge (optional)
            scroll_speed = 1, -- Scroll 1 line
          },
        }
      }
    }
    telescope.load_extension('fzf')
    telescope.load_extension('file_browser')

    require('notify').setup {
      on_open = function (win)
        -- Prevent focus on notify windows
        -- https://github.com/rcarriga/nvim-notify/issues/119#issuecomment-1210281504
        vim.api.nvim_win_set_config(win, { focusable = false })
      end,
    }

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
      messages = {
        view = "mini",
      },
      routes = {
        {
          filter = { event = "cmdline", kind = "cmdline", find ="echom a:message" },
          view = "mini",
          opts = { skip = false },
        }
      }
    }
  end)

  return hooks
end


return {
  get = from_opts
}
