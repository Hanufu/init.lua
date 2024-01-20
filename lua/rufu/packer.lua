-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    --plugin to search file and more
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use({ 'rose-pine/neovim', as = 'rose-pine' })                 --Theme Rose-Pine
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' }) --Define the highlighting in all programming languages

    --LPS
    use {
        'williamboman/mason.nvim' ,
        'williamboman/mason-lspconfig.nvim',
        -- LSP Support
         'neovim/nvim-lspconfig' ,
        -- Autocompletion
         'hrsh7th/nvim-cmp' ,
         'hrsh7th/cmp-nvim-lsp' ,
         'hrsh7th/cmp-buffer' ,
         'hrsh7th/cmp-path' ,
         'hrsh7th/cmp-nvim-lua' ,
         'hrsh7th/cmp-cmdline' ,
         'saadparwaiz1/cmp_luasnip' ,
         'rafamadriz/friendly-snippets' ,
         'ray-x/lsp_signature.nvim' ,
     'L3MON4D3/LuaSnip' ,
         'onsails/lspkind-nvim',
        { 'tzachar/cmp-tabnine',              run = './install.sh', requires = 'hrsh7th/nvim-cmp' },
    }

    -- Explorador de Arquivos tree
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }
    -- Terminal integrado
    use { "akinsho/toggleterm.nvim"}

    -- Debug Adapter - DAP
    use { "mfussenegger/nvim-lint"}
    use { "mhartington/formatter.nvim" }



end)
