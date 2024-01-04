local lsp_zero = require('lsp-zero')
local lsp_config = require('lspconfig')

lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
    lsp_zero.buffer_autoformat()
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
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

-- C and CPP
lsp_config.clangd.setup({
    single_file_support = true,
    cmd = { "clangd" }, -- Path to clangd executable if it's not in the system PATH
    capabilities = {
        offsetEncoding = { "utf-8" },
        -- Add any additional capabilities here if needed
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
        vim.keymap.set('n', '<leader>ss', '<cmd>ClangdSwitchSourceHeader<CR>', { noremap = true, silent = true })
    end

})
