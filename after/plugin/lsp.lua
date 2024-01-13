local lsp_zero = require('lsp-zero')
local lsp_config = require('lspconfig')
local lsp_signature = require("lsp_signature")

-- Configurações do lsp-zero
lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
    lsp_zero.buffer_autoformat()
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
    vim.keymap.set('n', '<sapace>d', vim.diagnostic.open_float)
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = bufnr })
end)

lsp_zero.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    }
})

lsp_zero.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '»'
})

-- Lua
lsp_config.lua_ls.setup({})

-- Configuração do clangd
lsp_config.clangd.setup({
    single_file_support = true,
    cmd = { "clangd" },
    capabilities = {
        offsetEncoding = { "utf-8" },
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    root_dir = lsp_config.util.root_pattern(
        '.clangd',
        '.clang-tidy',
        '.clang-format',
        'compile_commands.json',
        'compile_flags.txt',
        'configure.ac',
        '.git'
    ),
    on_attach = function(client, bufnr)
        -- Com o toggleTerm
        vim.api.nvim_set_keymap('n', '<F6>', [[:lua CompileAndRunCpp()<CR>]], { noremap = true, silent = true })        -- Sem o toggleTerm
        -- Sem o toggleTerm
        vim.keymap.set('n', '<F5>', [[:w<CR>:!g++ % -o %:r && %:r && rm %:r<CR>]], { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>ss', '<cmd>ClangdSwitchSourceHeader<CR>', { noremap = true, silent = true })
    end
})

-- CSharp
lsp_config.csharp_ls.setup {
    cmd = { "csharp-ls" },
    filetypes = { "cs" },
    init_options = {
        AutomaticWorkspaceInit = true
    },
}

-- GOLang
lsp_config.gopls.setup({
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
        },
    },
    on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    end,
})

-- Configurações do LSP Signature
lsp_signature.setup()

require("luasnip/loaders/from_vscode").load()
