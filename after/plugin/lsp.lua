local lsp_zero = require('lsp-zero')
local lsp_config = require('lspconfig')
local lsp_signature = require("lsp_signature")
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local cmp = require 'cmp'
local luasnip = require("luasnip")
local lspkind = require('lspkind')

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

-- ToggleTerm
function CompileAndRunCpp()
    local filename = vim.fn.expand('%')
    local executable = vim.fn.expand('%:r')

    -- Verificar se já existe um executável com o mesmo nome e excluí-lo
    local existing_executable = executable
    if vim.fn.filereadable(existing_executable) == 1 then
        vim.fn.delete(existing_executable)
    end

    -- Comando de compilação
    local compile_command = string.format('g++ %s -o %s', filename, executable)

    -- Adicionar um comando para excluir o executável no evento de fechamento do toggleterm
    local delete_executable_command = string.format("!rm %s", executable)
    local toggleterm_command = string.format('ToggleTerm --dir="%s" --title="%s" --noclose=1', vim.fn.getcwd(), executable)

    -- Executar o comando de compilação
    vim.cmd('echohl WarningMsg | echom "Compiling..." | echohl NONE')
    vim.fn.system(compile_command)

    -- Aguardar um momento para garantir que o toggleterm tenha tempo para abrir
    vim.cmd('sleep 100m')

    -- Abrir o toggleterm
    vim.cmd(toggleterm_command)

    -- Adicionar o comando de exclusão do executável no evento de fechamento do toggleterm
    vim.cmd(string.format("autocmd TermClose <buffer> %s", delete_executable_command))
end

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

-- Configurações do cmp_nvim_lsp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.setup({ capabilities = capabilities })

-- Configurações do cmp
local source_mapping = {
    buffer = "◉ Buffer",
    nvim_lsp = "👐 LSP",
    nvim_lua = "🌙 Lua",
    cmp_tabnine = "💡 Tabnine",
    path = "🚧 Path",
    luasnip = "🌜 LuaSnip"
}

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'nvim_lua' },
    },

    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            local menu = source_mapping[entry.source.name]
            if entry.source.name == 'cmp_tabnine' then
                if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                    menu = entry.completion_item.data.detail .. ' ' .. menu
                end
                vim_item.kind = ''
            end
            vim_item.menu = menu
            return vim_item
        end
    },

    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-q>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
            else
                fallback()
            end
        end,
    },
})

require("luasnip/loaders/from_vscode").load()
