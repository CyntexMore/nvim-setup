local plugins = {
	{
		"rose-pine/neovim",
		name = "rose-pine",

		config = function()
			require("rose-pine").setup({
				variant = "moon",

				styles = {
					transparency = true,
				},
			})

			vim.cmd("colorscheme rose-pine-moon")
		end
	},
	{"nvim-tree/nvim-tree.lua",
  		version = "*",
  		lazy = false,
  		dependencies = {
	       		"nvim-tree/nvim-web-devicons",
	       	},
	       	config = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			vim.opt.termguicolors = true
    	       		require("nvim-tree").setup {}
	       	end,
  	},
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufReadPost",
		config = function()
			require("colorizer").setup()

			vim.defer_fn(function()
				require("colorizer").attach_to_buffer(0)
			end, 0)
		end
		},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("ibl").setup()
		end
		},
	{
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets"
			},
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },
      "hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path"
    },
    config = function()
      require("config.configs.cmp")
    end,
  	},
	{
    "neovim/nvim-lspconfig",
    config = function ()
      require "config.configs.lspconfig"
    end
  },
  {
    "williamboman/mason.nvim",
    cmd = {"Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate"},
    opts = function()
      return require("config.configs.mason")
    end,
    config = function(_, opts)
      require("mason").setup(opts)
      vim.api.nvim_create_user_command("MasonInstallAll", function()
				if opts.ensure_installed and #opts.ensure_installed > 0 then
					vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
				end
      end, {})

      vim.g.mason_binaries_list = opts.ensure_installed
    end
  	},
	{
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("config.configs.telescope")
    end
  	},
	{
    "nvim-treesitter/nvim-treesitter",
    event = {"BufReadPost", "BufNewFile"},
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
					"c",
					"cpp",
					"lua",
					"bash",
					"html",
					"css",
					"typescript",
					"javascript",
					"python",
					"markdown",
					"json",
				},
				highlight = {
					enable = true
				}
      })
    end
  	},	
	{
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  	},
	{
    "nvimdev/guard.nvim",
    dependencies = {
      "nvimdev/guard-collection"
    },
    event = "BufReadPre",
    config = function ()
      local ft = require("guard.filetype")

      ft("c,cpp,h"):fmt("clang-format")
      ft("json"):fmt({
        cmd = "jq",
        stdin = true
      })

      require("guard").setup({
        fmt_on_save = true,
        lsp_as_default_formatter = false
      })
    end
  	},
	{
    "b0o/schemastore.nvim",
    ft = "json",
  	},
	{
		"lervag/vimtex",
		lazy = false,
		dependencies = "micangl/cmp-vimtex",
		init = function()
			vim.g.vimtex_view_method = 'mupdf'
		end
		},
}
return plugins
