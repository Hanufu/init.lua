require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
  ...
})
require("dapui").setup()

-- Caminho completo para o executável netcoredbg
local netcoredbg_path = '/home/rufu/.local/share/nvim/mason/packages/netcoredbg/netcoredbg'
local dap = require("dap")
-- Configuração do DAP
dap.adapters.coreclr = {
  type = 'executable',
  command = netcoredbg_path,
  args = {'--interpreter=vscode'}
}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/net8.0/', 'file')
    end,
  },
}
vim.api.nvim_set_keymap('n', '<leader>du', ':lua require"dapui".toggle()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F5>', ':lua require("dap").continue()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F10>', ':lua require("dap").step_over()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F11>', ':lua require("dap").step_into()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F12>', ':lua require("dap").step_out()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>b', ':lua require("dap").toggle_breakpoint()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>B', ':lua require("dap").set_breakpoint()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>lp', ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dr', ':lua require("dap").repl.open()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dl', ':lua require("dap").run_last()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dh', ':lua require("dap.ui.widgets").hover()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dp', ':lua require("dap.ui.widgets").preview()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>df', ':lua require("dap.ui.widgets").centered_float(require("dap.ui.widgets").frames)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ds', ':lua require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes)<CR>', { noremap = true, silent = true })
