local lsp_zero = require('lsp-zero')
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
