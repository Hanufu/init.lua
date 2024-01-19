require("toggleterm").setup {
    size = 8,
    open_mapping = [[<C-\>]],
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 1,
    start_in_insert = true,
    persist_size = true,
    direction = 'horizontal',
}

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
    local toggleterm_command = string.format('ToggleTerm --dir="%s" --title="%s" --noclose=1', vim.fn.getcwd(),
        executable)

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
