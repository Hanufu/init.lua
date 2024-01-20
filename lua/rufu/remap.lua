vim.g.mapleader = " "
--vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set('n', ';', ':')
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("w")
    vim.cmd("so")
end)

--moves everything that is highlighted
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

--move cursor and stay in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

--Save With Ctrl + S
vim.keymap.set("n", "<C-s>", ":w<CR>")

--vim.keymap.set("x", "<leader>p", "\"_dp")
vim.keymap.set("i", "<C-c>", "<Esc>")

--vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- REGEX - With cursor under word, change to the any other word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Tree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", {})
vim.keymap.set("n", "<leader>pv", ":NvimTreeFocus<CR>", {})

-- Fechar a aba atual com <C-w>
vim.keymap.set("n", "<C-w>", ":tabclose<CR>")

-- Navegar em ABAS com o tab
vim.keymap.set("n", "<C-Tab>", ":tabnext<CR>")
vim.keymap.set("n", "<S-Tab>", ":tabprev<CR>")

-- Navegar nos BUFFERS com o tab
vim.keymap.set("n", "<C-j>", ":bnext<CR>")
vim.keymap.set("n", "<C-k>", ":bprev<CR>")

vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = bufnr })
