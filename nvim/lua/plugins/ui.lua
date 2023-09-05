return {
  "RRethy/vim-illuminate",
  'andersevenrud/nvim_context_vt',
  'brenoprata10/nvim-highlight-colors',
  {"ellisonleao/glow.nvim", config = true, cmd = "Glow"},
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function ()
      require("indent_blankline").setup {
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
      }
    end
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  },
  {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup({ options = { theme = 'powerline_dark' } })
    end
  },

  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {},
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme nightfox]])
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },
  {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig",
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup({})
    end
  },
  {
    'stevearc/aerial.nvim',
    opts = {},
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require('gitsigns').setup({})
    end

  },
  {
    'nvim-orgmode/orgmode',
    config = function()
      -- init.lua

      -- Load custom treesitter grammar for org filetype
      require('orgmode').setup_ts_grammar()

      -- Treesitter configuration
      require('nvim-treesitter.configs').setup{
        -- If TS highlights are not enabled at all, or disabled via `disable` prop,
        -- highlighting will fallback to default Vim syntax highlighting
        highlight = {
          enable = true,
          -- Required for spellcheck, some LaTex highlights and
          -- code block highlights that do not have ts grammar
          additional_vim_regex_highlighting = {'org'},
        },
        ensure_installed = {'org'}, -- Or run :TSUpdate org
        modules = {},
        ignore_install = {},
        auto_install = true,
        sync_install = true,
      }

      require('orgmode').setup({
        org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
        org_default_notes_file = '~/Dropbox/org/refile.org',
      })
    end
  },
  {
    'akinsho/org-bullets.nvim', 
    config = function()
      require('org-bullets').setup{
        symbols = {
          -- list symbol
          list = "•",
          -- headlines can be a list
          headlines = { "◉", "○", "✸", "✿" }
        },
      }
    end
  }
}
