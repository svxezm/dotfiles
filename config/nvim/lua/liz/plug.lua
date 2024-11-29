local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug 'rose-pine/neovim'
Plug 'williamboman/mason.nvim'
Plug 'tribela/vim-transparent'
Plug 'ThePrimeagen/harpoon'
Plug 'nvim-lua/plenary.nvim'
Plug 'mbbill/undotree'
Plug 'tpope/vim-fugitive'
Plug 'CRAG666/code_runner.nvim'
Plug ('nvim-telescope/telescope.nvim', { tag = '0.1.6' })

Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'

-- Auto completrion
Plug ('neoclide/coc.nvim', { branch = 'release', run = 'yarn install --frozen-lockfile' })
Plug 'neoclide/coc-tsserver'
Plug 'neoclide/coc-tslint-plugin'
Plug 'neoclide/coc-css'
Plug 'neoclide/coc-json'
Plug 'neoclide/coc-prettier'
Plug 'mattn/emmet-vim'

Plug 'norcalli/nvim-colorizer.lua'
Plug 'ap/vim-css-color'
Plug 'rstacruz/vim-closer'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'

-- JSX and tsX
Plug 'yuezk/vim-js'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'

-- C#
Plug 'jlcrochet/vim-razor'

vim.call('plug#end')

vim.cmd.colorscheme("rose-pine")

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    require("mason").setup()

    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

     use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            --- Uncomment the two plugins below if you want to manage the language servers from neovim
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'neovim/nvim-lspconfig'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }
end)
